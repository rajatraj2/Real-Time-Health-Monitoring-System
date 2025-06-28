import 'package:flutter/material.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = "";

  void _checkSymptoms() {
    String input = _controller.text.toLowerCase();

    // Simple symptom matching logic (you can replace this with OpenAI API later)
    if (input.contains("fever") && input.contains("cough")) {
      _response =
          "Possible Flu or Viral Infection. Please rest and stay hydrated.";
    } else if (input.contains("headache") && input.contains("blurred vision")) {
      _response = "May be Migraine or Eye Strain. Consider seeing a doctor.";
    } else {
      _response = "Sorry, unable to identify. Please consult a physician.";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Symptom Checker"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Describe your symptoms below:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g. fever and cough since 2 days",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkSymptoms,
              child: const Text("Check Symptoms"),
            ),
            const SizedBox(height: 20),
            Text(
              _response,
              style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
            )
          ],
        ),
      ),
    );
  }
}
