import 'package:flutter/material.dart';
import 'package:dih/profile_page.dart';

class HealthDashboardScreen extends StatefulWidget {
  const HealthDashboardScreen({super.key});

  @override
  State<HealthDashboardScreen> createState() => _HealthDashboardScreenState();
}

class _HealthDashboardScreenState extends State<HealthDashboardScreen> {
  int selectedIndex = 2;

  void onBottomTap(int index) {
    setState(() => selectedIndex = index);
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
    }
    // Add navigation for other screens here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification clicked')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bluetooth_connected, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('IoT connection clicked')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopGreeting(),
            const SizedBox(height: 16),
            _buildOverviewSection(),
            _buildGraphSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onBottomTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
        ],
        selectedItemColor: Colors.teal,
      ),
    );
  }

  Widget _buildTopGreeting() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(179, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
              fontFamily: 'Roboto',
            ),
            children: <TextSpan>[
              TextSpan(text: 'Hello, \n'),
              TextSpan(
                text: 'Rajat',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7154E3),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Insert your _buildOverviewSection, _buildGraphSection, and other supporting methods here from your previous code

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _buildOverviewCard(
            title: "Heart beats",
            value: "87",
            unit: "bpm",
            status: "Normal",
            icon: Icons.favorite_border,
            iconColor: Colors.pink,
            valueColor: const Color(0xFF673AB7),
          ),
          _buildOverviewCard(
            title: "Temperature",
            value: "99.3",
            unit: "°F",
            status: "Normal",
            icon: Icons.thermostat_outlined,
            iconColor: Colors.redAccent,
            valueColor: const Color(0xFF673AB7),
          ),
          _buildOverviewCard(
            title: "Blood Pressure",
            value: "117/75",
            unit: "mmHg",
            status: "Normal",
            icon: Icons.monitor_heart_outlined,
            iconColor: Colors.blueAccent,
            valueColor: const Color(0xFF673AB7),
          ),
          _buildOverviewCard(
            title: "SpO₂",
            value: "97",
            unit: "%",
            status: "Normal",
            icon: Icons.line_weight,
            iconColor: Colors.purpleAccent,
            valueColor: const Color(0xFF673AB7),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required String value,
    required String unit,
    required String status,
    required IconData icon,
    required Color iconColor,
    required Color valueColor,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Icon(icon, color: iconColor, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
                children: <TextSpan>[
                  TextSpan(text: value),
                  TextSpan(
                    text: ' $unit',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  status,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(26, 158, 158, 158),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.thermostat_outlined,
                  color: Colors.redAccent, size: 28),
              SizedBox(width: 8),
              Text("Temperature",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Text("25 July, 2025",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 16),
          _buildFilterButtons(),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _TemperatureChartPainter(),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterButton("Temperature", isSelected: true),
          const SizedBox(width: 10),
          _buildFilterButton("Heart Beats"),
          const SizedBox(width: 10),
          _buildFilterButton("SpO2"),
          const SizedBox(width: 10),
          _buildFilterButton("B P"),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF673AB7) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _TemperatureChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()..color = Colors.red;

    final path = Path();
    double startY = size.height * 0.7;
    double endY = size.height * 0.3;

    path.moveTo(0, startY);
    path.cubicTo(size.width * 0.2, startY, size.width * 0.2, endY,
        size.width * 0.4, endY);
    path.cubicTo(size.width * 0.6, endY, size.width * 0.6, startY,
        size.width * 0.8, startY);
    path.cubicTo(
        size.width * 0.9, startY, size.width * 0.9, endY, size.width, endY);

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(0, startY), 3.0, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.4, endY), 3.0, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.8, startY), 3.0, dotPaint);
    canvas.drawCircle(Offset(size.width, endY), 3.0, dotPaint);

    final axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
