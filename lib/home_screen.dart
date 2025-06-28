import 'package:dih/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For the 'Inter' font
import 'package:lucide_icons/lucide_icons.dart'; // For icons like Rocket, Lightbulb, TrendingUp, Sun, Moon, Menu, X, Bell, Wifi, Settings
import 'package:fl_chart/fl_chart.dart'; // For the health data charts

// Main entry point for the Flutter application
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
      title: 'DIH App',
      // Define the light theme for the application
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        // Apply 'Inter' font to the entire text theme
        textTheme:
            GoogleFonts.getTextTheme('Inter', Theme.of(context).textTheme)
                .apply(
          // Changed method here
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
        // Apply 'Inter' font to the entire text theme for dark mode
        textTheme:
            GoogleFonts.getTextTheme('Inter', Theme.of(context).textTheme)
                .apply(
          // Changed method here
          bodyColor: Colors.grey[100],
          displayColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[900], // Dark mode background color
      ),
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Set current theme mode
      // Set HealthDashboardScreen as the home screen, passing dark mode state and toggle
      home: HealthDashboardScreen(
        isDarkMode: _isDarkMode,
        toggleDarkMode: _toggleDarkMode,
      ),
      debugShowCheckedModeBanner:
          false, // Hide the debug banner in release mode
    );
  }
}

// Placeholder for ProfileScreen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text(
          'Profile Page Content',
          style: GoogleFonts.inter(
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}

// Placeholder for SettingScreen

// Custom AppBar widget for the top of the screen
class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onIoTTap;
  final VoidCallback onSettingsTap;
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const CustomTopAppBar({
    super.key,
    required this.onNotificationTap,
    required this.onIoTTap,
    required this.onSettingsTap,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Standard AppBar height

  @override
  Widget build(BuildContext context) {
    // Determine colors based on dark mode
    Color iconColor = isDarkMode ? Colors.grey[300]! : Colors.grey[700]!;
    Color appBarColor = isDarkMode
        ? Colors.grey[850]!
        : Colors.white; // Slightly darker for dark mode app bar
    Color rocketColor = isDarkMode ? Colors.blue[400]! : Colors.blue[600]!;
    Color titleColor = isDarkMode ? Colors.white : Colors.grey[900]!;

    return AppBar(
      backgroundColor: appBarColor,
      elevation: 4, // Subtle shadow for the app bar
      shadowColor: isDarkMode ? Colors.black54 : Colors.grey[200],
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.rocket, color: rocketColor, size: 30),
          const SizedBox(width: 8),
          Text(
            'DIH',
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: titleColor,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(LucideIcons.bell, color: iconColor),
          onPressed: onNotificationTap,
          tooltip: 'Notifications',
        ),
        IconButton(
          icon: Icon(LucideIcons.wifi, color: iconColor),
          onPressed: onIoTTap,
          tooltip: 'IoT Connection',
        ),
        IconButton(
          icon: Icon(LucideIcons.settings, color: iconColor),
          onPressed: onSettingsTap,
          tooltip: 'Settings',
        ),
        // Dark Mode Toggle Button
        IconButton(
          icon: Icon(
            isDarkMode ? LucideIcons.sun : LucideIcons.moon,
            color: isDarkMode ? Colors.yellow[400] : Colors.blue[600],
          ),
          onPressed: toggleDarkMode,
          tooltip: 'Toggle dark mode',
        ),
        const SizedBox(width: 8), // Padding on the right side
      ],
    );
  }
}

// HealthDashboardScreen is the main content screen of the application
class HealthDashboardScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const HealthDashboardScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  State<HealthDashboardScreen> createState() => _HealthDashboardScreenState();
}

class _HealthDashboardScreenState extends State<HealthDashboardScreen>
    with TickerProviderStateMixin {
  // Not used in this version, as navigation is handled by AppBar actions
  int selectedIndex = 2;

  // Currently selected health metric for the graph
  String selectedMetric = "Temperature";

  // Dummy method for bottom tap, will not be called in this setup
  void onBottomTap(int index) {
    setState(() => selectedIndex = index);
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  // List of available health metrics
  final List<String> metrics = [
    "Temperature",
    "Heart Beats",
    "SpO2",
    "BP",
    "Blood Sugar",
    "Oxygen Saturation",
    "BMI",
    "Sleep Cycle"
  ];

  // Dummy data for each health metric to be displayed in the graph
  final Map<String, List<FlSpot>> metricData = {
    "Temperature": [
      const FlSpot(0, 98.6),
      const FlSpot(1, 99.1),
      const FlSpot(2, 99.3),
      const FlSpot(3, 98.7)
    ],
    "Heart Beats": [
      const FlSpot(0, 80),
      const FlSpot(1, 82),
      const FlSpot(2, 78),
      const FlSpot(3, 85)
    ],
    "SpO2": [
      const FlSpot(0, 96),
      const FlSpot(1, 97),
      const FlSpot(2, 95),
      const FlSpot(3, 98)
    ],
    "BP": [
      const FlSpot(0, 120),
      const FlSpot(1, 115),
      const FlSpot(2, 118),
      const FlSpot(3, 117)
    ],
    "Blood Sugar": [
      const FlSpot(0, 95),
      const FlSpot(1, 100),
      const FlSpot(2, 105),
      const FlSpot(3, 110)
    ],
    "Oxygen Saturation": [
      const FlSpot(0, 96),
      const FlSpot(1, 95),
      const FlSpot(2, 97),
      const FlSpot(3, 96)
    ],
    "BMI": [
      const FlSpot(0, 22),
      const FlSpot(1, 22.1),
      const FlSpot(2, 21.8),
      const FlSpot(3, 22.3)
    ],
    "Sleep Cycle": [
      const FlSpot(0, 6),
      const FlSpot(1, 7),
      const FlSpot(2, 6.5),
      const FlSpot(3, 8)
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Determine colors based on the current dark mode state
    Color backgroundColor =
        widget.isDarkMode ? Colors.grey[900]! : const Color(0xFFE0F7FA);
    Color primaryTextColor =
        widget.isDarkMode ? Colors.grey[100]! : Colors.grey[800]!;
    Color secondaryTextColor =
        widget.isDarkMode ? Colors.grey[300]! : Colors.grey[700]!;
    Color cardColor = widget.isDarkMode ? Colors.grey[800]! : Colors.white;
    Color shadowColor = widget.isDarkMode ? Colors.black : Colors.grey[300]!;
    Color accentColor = const Color(0xFF7154E3); // Consistent accent color

    return Scaffold(
      backgroundColor: backgroundColor,
      // Custom AppBar for notifications, IoT, settings, and dark mode toggle
      appBar: CustomTopAppBar(
        onNotificationTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notifications clicked')),
          );
        },
        onIoTTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Connecting to IoT...')),
          );
        },
        onSettingsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingScreen()),
          );
        },
        isDarkMode: widget.isDarkMode,
        toggleDarkMode: widget.toggleDarkMode,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // "Hello, Rajat" greeting section
            _buildTopGreeting(primaryTextColor, accentColor, cardColor),
            const SizedBox(height: 16),
            // Overview health metrics section (Heart Beats, Temperature, BP, SpO2)
            _buildOverviewSection(
                cardColor,
                primaryTextColor,
                secondaryTextColor,
                shadowColor,
                accentColor), // Passed accentColor here
            const SizedBox(height: 24),
            // Metric tabs for selecting health data to display in graph
            _buildMetricTabs(primaryTextColor, accentColor, cardColor),
            const SizedBox(height: 16),
            // Animated graph section based on selected metric
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildGraphSection(selectedMetric, cardColor,
                  primaryTextColor, secondaryTextColor, shadowColor),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Widget to build the "Hello, Rajat" greeting card
  Widget _buildTopGreeting(
      Color primaryTextColor, Color accentColor, Color cardBgColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode
                  ? Colors.black45
                  : Colors.grey.withAlpha((255 * 0.2).round()),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              // Using GoogleFonts for consistency
              fontSize: 30,
              fontWeight: FontWeight.w400, // Normal weight
              color: primaryTextColor,
            ),
            children: <TextSpan>[
              const TextSpan(text: 'Hello, \n'),
              TextSpan(
                text: 'Rajat',
                style: GoogleFonts.inter(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Widget to build the health overview section with a GridView of cards
  Widget _buildOverviewSection(Color cardBgColor, Color titleColor,
      Color secondaryTextColor, Color shadowColor, Color accentColor) {
    // Added accentColor parameter here
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        shrinkWrap: true, // Allows GridView to take only necessary space
        physics:
            const NeverScrollableScrollPhysics(), // Disables GridView's internal scrolling
        crossAxisCount: MediaQuery.of(context).size.width > 600
            ? 3
            : 2, // Responsive columns
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _buildOverviewCard(
            title: "Heart Beats",
            value: "87",
            unit: "bpm",
            status: "Normal",
            icon: LucideIcons.heartPulse, // Using Lucide icon
            iconColor: Colors.pink,
            valueColor:
                accentColor, // This now correctly refers to the passed accentColor
            cardBgColor: cardBgColor,
            titleColor: titleColor,
            shadowColor: shadowColor,
          ),
          _buildOverviewCard(
            title: "Temperature",
            value: "99.3",
            unit: "°F",
            status: "Normal",
            icon: LucideIcons.thermometer, // Using Lucide icon
            iconColor: Colors.redAccent,
            valueColor: accentColor, // Corrected
            cardBgColor: cardBgColor,
            titleColor: titleColor,
            shadowColor: shadowColor,
          ),
          _buildOverviewCard(
            title: "Blood Pressure",
            value: "117/75",
            unit: "mmHg",
            status: "Normal",
            icon: LucideIcons.gauge, // Using Lucide icon
            iconColor: Colors.blueAccent,
            valueColor: accentColor, // Corrected
            cardBgColor: cardBgColor,
            titleColor: titleColor,
            shadowColor: shadowColor,
          ),
          _buildOverviewCard(
            title: "SpO₂",
            value: "97",
            unit: "%",
            status: "Normal",
            icon: LucideIcons.activity, // Using Lucide icon for SpO₂
            iconColor: Colors.purpleAccent,
            valueColor: accentColor, // Corrected
            cardBgColor: cardBgColor,
            titleColor: titleColor,
            shadowColor: shadowColor,
          ),
        ],
      ),
    );
  }

  // Widget to build individual overview cards within the dashboard
  Widget _buildOverviewCard({
    required String title,
    required String value,
    required String unit,
    required String status,
    required IconData icon,
    required Color iconColor,
    required Color valueColor,
    required Color cardBgColor,
    required Color titleColor,
    required Color shadowColor,
  }) {
    return Card(
      color: cardBgColor,
      elevation: 6, // Increased elevation for better visual depth
      shadowColor: shadowColor.withAlpha((255 * 0.2).round()),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18)), // Slightly more rounded corners
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        color: titleColor.withAlpha((255 * 0.7).round()),
                        fontWeight: FontWeight.w500)),
                Icon(icon, color: iconColor, size: 24), // Increased icon size
              ],
            ),
            const SizedBox(height: 12), // Increased spacing
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  // Using GoogleFonts
                  fontSize: 28, // Increased font size for value
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
                children: <TextSpan>[
                  TextSpan(text: value),
                  TextSpan(
                    text: ' $unit',
                    style: GoogleFonts.inter(
                      // Using GoogleFonts
                      fontSize: 18, // Increased font size for unit
                      fontWeight: FontWeight.normal,
                      color: titleColor.withAlpha((255 * 0.6).round()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // Increased spacing
            Row(
              children: [
                Container(
                  width: 10, // Larger status indicator
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[400], // Brighter green for status
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8), // Increased spacing
                Text(status,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: titleColor.withAlpha((255 * 0.7).round()),
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the horizontal scrollable tabs for metrics
  Widget _buildMetricTabs(
      Color primaryTextColor, Color accentColor, Color cardBgColor) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0), // Padding for the scroll view
      child: Row(
        children: metrics.map((metric) {
          final isSelected = selectedMetric == metric;
          return GestureDetector(
            onTap: () => setState(() => selectedMetric = metric),
            child: AnimatedContainer(
              duration: const Duration(
                  milliseconds: 300), // Smooth animation for selection
              margin:
                  const EdgeInsets.symmetric(horizontal: 8), // Increased margin
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12), // Increased padding
              decoration: BoxDecoration(
                color: isSelected
                    ? accentColor
                    : cardBgColor, // Use cardBgColor for unselected
                borderRadius:
                    BorderRadius.circular(25), // More rounded corners for tabs
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: accentColor.withAlpha((255 * 0.4).round()),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black38
                              : Colors.grey.withAlpha((255 * 0.1).round()),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Text(
                metric,
                style: GoogleFonts.inter(
                  // Using GoogleFonts
                  color: isSelected
                      ? Colors.white
                      : primaryTextColor.withAlpha((255 * 0.8).round()),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Widget to build the line graph section for the selected metric
  Widget _buildGraphSection(String metric, Color cardBgColor,
      Color primaryTextColor, Color secondaryTextColor, Color shadowColor) {
    return Container(
      key: ValueKey(metric), // Key for AnimatedSwitcher to identify changes
      margin: const EdgeInsets.symmetric(horizontal: 16.0), // Consistent margin
      padding: const EdgeInsets.all(24.0), // Increased padding
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius:
            BorderRadius.circular(20), // More rounded corners for graph card
        boxShadow: [
          BoxShadow(
            color: shadowColor.withAlpha((255 * 0.2).round()),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.activity,
                  color: Theme.of(context).primaryColor,
                  size: 28), // Consistent icon for graph
              const SizedBox(width: 12), // Increased spacing
              Text(
                metric,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12), // Increased spacing
          Text("25 July, 2025",
              style:
                  GoogleFonts.inter(fontSize: 15, color: secondaryTextColor)),
          const SizedBox(height: 20), // Increased spacing
          SizedBox(
            height: 200, // Increased height for better graph visibility
            child: LineChart(
              LineChartData(
                titlesData: const FlTitlesData(
                    show: false), // Hide titles for cleaner look
                gridData: const FlGridData(show: false), // Hide grid lines
                borderData: FlBorderData(show: false), // Hide border
                minX: 0,
                maxX: metricData[metric]!.length - 1.0,
                minY: _getMinY(metric),
                maxY: _getMaxY(metric),
                lineBarsData: [
                  LineChartBarData(
                    spots: metricData[metric] ?? [const FlSpot(0, 0)],
                    isCurved: true,
                    gradient: LinearGradient(
                      // Gradient for the line
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.purpleAccent
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    barWidth: 4, // Thicker line
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        // Area gradient
                        colors: [
                          Theme.of(context)
                              .primaryColor
                              .withAlpha((255 * 0.3).round()),
                          Colors.purpleAccent.withAlpha((255 * 0.1).round()),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    dotData: FlDotData(
                      // Custom dots
                      show: true,
                      getDotPainter: (spot, percent, bar, index) =>
                          FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Helper to get minimum Y-axis value for the graph based on metric
  double _getMinY(String metric) {
    if (metricData[metric] == null || metricData[metric]!.isEmpty) return 0;
    return metricData[metric]!
            .map((spot) => spot.y)
            .reduce((a, b) => a < b ? a : b) -
        2; // Add some padding
  }

  // Helper to get maximum Y-axis value for the graph based on metric
  double _getMaxY(String metric) {
    if (metricData[metric] == null || metricData[metric]!.isEmpty) return 10;
    return metricData[metric]!
            .map((spot) => spot.y)
            .reduce((a, b) => a > b ? a : b) +
        2; // Add some padding
  }
}
