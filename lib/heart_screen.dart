import 'package:flutter/material.dart';

class HeartScreen extends StatelessWidget {
  const HeartScreen({super.key});

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Health Analysis Report ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF673AB7),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildAlertCard(
                  context,
                  title: "High Heart Rate",
                  value: "152 bpm",
                  status: "Critical",
                  color: Colors.redAccent,
                  time: "25 June 2025, 11:15 AM",
                  suggestion: "Take immediate rest and consult a doctor.",
                ),
                const SizedBox(height: 16),
                _buildAlertCard(
                  context,
                  title: "Low Heart Rate",
                  value: "48 bpm",
                  status: "Low",
                  color: Colors.orangeAccent,
                  time: "22 June 2025, 9:30 PM",
                  suggestion: "Consider doing light physical activity.",
                ),
                const SizedBox(height: 16),
                _buildAlertCard(
                  context,
                  title: "Normal Heart Rate",
                  value: "82 bpm",
                  status: "Stable",
                  color: Colors.green,
                  time: "20 June 2025, 4:10 PM",
                  suggestion: "No action needed.",
                ),
                const SizedBox(height: 24),

                // Ask with AI Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('AI Assistant Coming Soon!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text(
                      "Ask with AI",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(
    BuildContext context, {
    required String title,
    required String value,
    required String status,
    required Color color,
    required String time,
    required String suggestion,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monitor_heart, color: color),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Value: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(value),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(status),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("Time: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(time),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Suggestion:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(suggestion, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
