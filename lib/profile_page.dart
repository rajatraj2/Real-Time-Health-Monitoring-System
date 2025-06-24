import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_alt_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile picture and name
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.asset(
                        'assets/profile.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Rajat Raj",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Stats card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("Age", "22"),
                    _buildDivider(),
                    _buildStatItem("Height", "176"),
                    _buildDivider(),
                    _buildStatItem("Weight", "79"),
                    _buildDivider(),
                    _buildStatItem("Blood", "A+"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Check-up history section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Check-Up History",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6750A4),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "view all",
                          style: TextStyle(color: Colors.purple.shade400),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            color: Colors.purple.shade400),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // History cards
              Flexible(
                child: ListView(
                  children: [
                    _buildHistoryCard(
                      icon: Icons.thermostat_outlined,
                      iconColor: Colors.red,
                      title: "Fever",
                      date: "27 May, 2025",
                      symptoms: ["Temp(medium)", "Headache(medium)"],
                      note: "Need little bit of rest!!",
                    ),
                    const SizedBox(height: 16),
                    _buildHistoryCard(
                      icon: Icons.favorite_outline,
                      iconColor: Colors.red,
                      title: "Heart Attack",
                      date: "",
                      symptoms: [],
                      note:
                          "Body text for whatever you'd like to say. Add main takeaway points, quotes, anecdotes, or even a very short story.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 40, width: 1, color: Colors.grey.shade300);
  }

  Widget _buildHistoryCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
    required List<String> symptoms,
    required String note,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (date.isNotEmpty)
                    Text(date, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ],
          ),
          if (symptoms.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Symptoms: ",
                  style: TextStyle(color: Colors.purple.shade400),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: symptoms.map((symptom) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(symptom),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
          if (note.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(note, style: TextStyle(color: Colors.blue.shade300)),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.purple.shade400),
                onPressed: () {},
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade100,
                  foregroundColor: Colors.green.shade700,
                  elevation: 0,
                ),
                child: const Text("View"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
