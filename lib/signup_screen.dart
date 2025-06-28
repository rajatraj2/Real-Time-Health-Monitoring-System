import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For the 'Inter' font
import 'package:lucide_icons/lucide_icons.dart'; // For icons like Mail, Lock, User, Phone, Calendar, Gender, Key

void main() {
  runApp(const MyApp());
}

// MyApp is the root widget, managing the dark mode state
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // State variable to control dark mode

  // Toggles the dark mode state and rebuilds the UI
  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIH App - Sign Up',
      // Define the light theme for the application
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        textTheme:
            GoogleFonts.getTextTheme('Inter', Theme.of(context).textTheme)
                .apply(
          bodyColor: Colors.grey[800],
          displayColor: Colors.grey[900],
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor:
            const Color(0xFFE0F7FA), // Light mode background color
      ),
      // Define the dark theme for the application
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme:
            GoogleFonts.getTextTheme('Inter', Theme.of(context).textTheme)
                .apply(
          bodyColor: Colors.grey[100],
          displayColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[900], // Dark mode background color
      ),
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Set current theme mode
      home: SignupScreen(
          isDarkMode: _isDarkMode, toggleDarkMode: _toggleDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Placeholder for LoginScreen
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('लॉगिन करें'), // Login (Hindi)
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text(
          'लॉगिन पेज पर आपका स्वागत है!', // Welcome to Login Page! (Hindi)
          style: GoogleFonts.inter(
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const SignupScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDateOfBirth;

  final _formKey = GlobalKey<FormState>(); // Key for primary form validation
  final _otpFormKey = GlobalKey<FormState>(); // Key for OTP form validation

  bool _isOtpSent = false; // State to control OTP section visibility

  // Function to handle sign up logic
  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'पासवर्ड मेल नहीं खाते!')), // Passwords do not match! (Hindi)
        );
      } else {
        // Simulate OTP sending
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'OTP भेजा जा रहा है ${_mobileController.text} पर...')), // Sending OTP to... (Hindi)
        );
        setState(() {
          _isOtpSent = true; // Show OTP section
        });
        // In a real app, send OTP to mobile/email via an API here
      }
    }
  }

  // Function to handle OTP verification
  void _verifyOtp() {
    if (_otpFormKey.currentState!.validate()) {
      // Simulate OTP verification
      if (_otpController.text == "123456") {
        // Dummy OTP for simulation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'OTP सत्यापित हुआ! खाते का निर्माण हो रहा है...')), // OTP verified! Creating account... (Hindi)
        );
        // Navigate to Login Page after successful sign-up and OTP verification
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'अमान्य OTP! कृपया पुनः प्रयास करें।')), // Invalid OTP! Please try again. (Hindi)
        );
      }
    }
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: widget.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine colors based on dark mode
    Color primaryTextColor =
        widget.isDarkMode ? Colors.grey[100]! : Colors.grey[800]!;
    Color secondaryTextColor =
        widget.isDarkMode ? Colors.grey[300]! : Colors.grey[700]!;
    Color cardColor = widget.isDarkMode ? Colors.grey[800]! : Colors.white;
    Color accentColor = const Color(0xFF7154E3); // Consistent accent color
    Color gradientStart =
        widget.isDarkMode ? Colors.blue[600]! : Colors.blue[500]!;
    Color gradientEnd =
        widget.isDarkMode ? Colors.purple[700]! : Colors.purple[600]!;

    return Scaffold(
      backgroundColor:
          widget.isDarkMode ? Colors.grey[900] : const Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.grey[850] : Colors.white,
        elevation: 4,
        shadowColor: widget.isDarkMode ? Colors.black54 : Colors.grey[200],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.rocket,
                color: widget.isDarkMode ? Colors.blue[400] : Colors.blue[600],
                size: 30),
            const SizedBox(width: 8),
            Text(
              'DIH',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: primaryTextColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? LucideIcons.sun : LucideIcons.moon,
              color: widget.isDarkMode ? Colors.yellow[400] : Colors.blue[600],
            ),
            onPressed: widget.toggleDarkMode,
            tooltip: 'थीम बदलें', // Toggle theme (Hindi)
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 450), // Increased max width for more fields
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'अपना DIH खाता बनाएँ', // Create Your DIH Account (Hindi)
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Name Field
                  _buildTextField(
                    controller: _nameController,
                    hintText: 'पूरा नाम', // Full Name (Hindi)
                    icon: LucideIcons.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'कृपया अपना पूरा नाम दर्ज करें'; // Please enter your full name (Hindi)
                      }
                      return null;
                    },
                    isDarkMode: widget.isDarkMode,
                    cardColor: cardColor,
                    primaryTextColor: primaryTextColor,
                  ),
                  const SizedBox(height: 20),
                  // Mobile Field
                  _buildTextField(
                    controller: _mobileController,
                    hintText: 'मोबाइल नंबर', // Mobile Number (Hindi)
                    icon: LucideIcons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' कृपया अपना मोबाइल नंबर दर्ज करें'; // Please enter your mobile number (Hindi)
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'कृपया एक वैध 10-अंकीय मोबाइल नंबर दर्ज करें'; // Please enter a valid 10-digit mobile number (Hindi)
                      }
                      return null;
                    },
                    isDarkMode: widget.isDarkMode,
                    cardColor: cardColor,
                    primaryTextColor: primaryTextColor,
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'ईमेल', // Email (Hindi)
                    icon: LucideIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'कृपया अपना ईमेल दर्ज करें'; // Please enter your email (Hindi)
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'कृपया एक वैध ईमेल पता दर्ज करें'; // Please enter a valid email address (Hindi)
                      }
                      return null;
                    },
                    isDarkMode: widget.isDarkMode,
                    cardColor: cardColor,
                    primaryTextColor: primaryTextColor,
                  ),
                  const SizedBox(height: 20),
                  // Gender Dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: widget.isDarkMode
                              ? Colors.black38
                              : Colors.grey.withAlpha((255 * 0.1).round()),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      hint: Text(
                        'लिंग चुनें', // Select Gender (Hindi)
                        style: GoogleFonts.inter(
                            color: primaryTextColor
                                .withAlpha((255 * 0.6).round())),
                      ),
                      icon: Icon(LucideIcons.chevronDown,
                          color:
                              primaryTextColor.withAlpha((255 * 0.7).round())),
                      decoration: InputDecoration(
                        prefixIcon: Icon(LucideIcons.user,
                            color: primaryTextColor
                                .withAlpha((255 * 0.7).round())),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                      style: GoogleFonts.inter(color: primaryTextColor),
                      dropdownColor:
                          cardColor, // Dropdown menu background color
                      items: <String>[
                        'पुरुष',
                        'महिला',
                        'अन्य'
                      ] // Male, Female, Other (Hindi)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'कृपया अपना लिंग चुनें'; // Please select your gender (Hindi)
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Date of Birth Field
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: widget.isDarkMode
                                ? Colors.black38
                                : Colors.grey.withAlpha((255 * 0.1).round()),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AbsorbPointer(
                        // Prevents keyboard from appearing
                        child: TextFormField(
                          controller: TextEditingController(
                            text: _selectedDateOfBirth == null
                                ? ''
                                : '${_selectedDateOfBirth!.day}/${_selectedDateOfBirth!.month}/${_selectedDateOfBirth!.year}',
                          ),
                          readOnly: true, // Make it read-only
                          decoration: InputDecoration(
                            hintText: 'जन्मतिथि', // Date of Birth (Hindi)
                            hintStyle: GoogleFonts.inter(
                                color: primaryTextColor
                                    .withAlpha((255 * 0.6).round())),
                            prefixIcon: Icon(LucideIcons.calendar,
                                color: primaryTextColor
                                    .withAlpha((255 * 0.7).round())),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 0),
                          ),
                          style: GoogleFonts.inter(color: primaryTextColor),
                          validator: (value) {
                            if (_selectedDateOfBirth == null) {
                              return 'कृपया अपनी जन्मतिथि चुनें'; // Please select your date of birth (Hindi)
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'पासवर्ड', // Password (Hindi)
                    icon: LucideIcons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'कृपया अपना पासवर्ड दर्ज करें'; // Please enter your password (Hindi)
                      }
                      if (value.length < 6) {
                        return 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए'; // Password must be at least 6 characters long (Hindi)
                      }
                      return null;
                    },
                    isDarkMode: widget.isDarkMode,
                    cardColor: cardColor,
                    primaryTextColor: primaryTextColor,
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password Field
                  _buildTextField(
                    controller: _confirmPasswordController,
                    hintText:
                        'पासवर्ड की पुष्टि करें', // Confirm Password (Hindi)
                    icon: LucideIcons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'कृपया अपने पासवर्ड की पुष्टि करें'; // Please confirm your password (Hindi)
                      }
                      if (value != _passwordController.text) {
                        return 'पासवर्ड मेल नहीं खाते'; // Passwords do not match (Hindi)
                      }
                      return null;
                    },
                    isDarkMode: widget.isDarkMode,
                    cardColor: cardColor,
                    primaryTextColor: primaryTextColor,
                  ),
                  const SizedBox(height: 40),

                  // Conditional rendering for OTP section
                  if (!_isOtpSent)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: widget.isDarkMode
                              ? Colors.black54
                              : Colors.grey[300],
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [gradientStart, gradientEnd],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'खाता बनाएँ', // Create Account (Hindi)
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  else // OTP verification section
                    Form(
                      key: _otpFormKey,
                      child: Column(
                        children: [
                          Text(
                            'आपके मोबाइल नंबर पर OTP भेजा गया है।', // OTP sent to your mobile number. (Hindi)
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: secondaryTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _otpController,
                            hintText: 'OTP दर्ज करें', // Enter OTP (Hindi)
                            icon: LucideIcons.key,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'कृपया OTP दर्ज करें'; // Please enter OTP (Hindi)
                              }
                              if (value.length != 6) {
                                return 'OTP 6 अंकों का होना चाहिए'; // OTP should be 6 digits (Hindi)
                              }
                              return null;
                            },
                            isDarkMode: widget.isDarkMode,
                            cardColor: cardColor,
                            primaryTextColor: primaryTextColor,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _verifyOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 8,
                                shadowColor: widget.isDarkMode
                                    ? Colors.black54
                                    : Colors.grey[300],
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [gradientStart, gradientEnd],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'OTP सत्यापित करें', // Verify OTP (Hindi)
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'OTP पुनः भेजा जा रहा है...')), // Resending OTP... (Hindi)
                              );
                              // Implement OTP resend logic here
                            },
                            child: Text(
                              'OTP पुनः भेजें', // Resend OTP (Hindi)
                              style: GoogleFonts.inter(
                                color: accentColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                  // Already have an account? Login link
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: Text(
                      'पहले से खाता है? लॉगिन करें', // Already have an account? Log In (Hindi)
                      style: GoogleFonts.inter(
                        color: accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for building styled text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
    required bool isDarkMode,
    required Color cardColor,
    required Color primaryTextColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black38
                : Colors.grey.withAlpha((255 * 0.1).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: GoogleFonts.inter(color: primaryTextColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
              color: primaryTextColor.withAlpha((255 * 0.6).round())),
          prefixIcon: Icon(icon,
              color: primaryTextColor.withAlpha((255 * 0.7).round())),
          border: InputBorder.none, // Remove default border
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }
}
