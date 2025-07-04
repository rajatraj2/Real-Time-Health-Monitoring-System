import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'disease_predictor.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _spo2Controller = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();

  String? _prediction;
  bool _isLoading = false;

  late DiseasePredictor _predictor;

  @override
  void initState() {
    super.initState();
    _predictor = DiseasePredictor();
    _predictor.loadModel();
  }

  Future<void> _predictDisease() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final heartRate = double.parse(_heartRateController.text);
      final spo2 = double.parse(_spo2Controller.text);
      final glucose = double.parse(_glucoseController.text);

      final result = await _predictor.predict(
        heartRate: heartRate,
        spo2: spo2,
        glucose: glucose,
      );

      setState(() {
        _prediction = result;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _heartRateController.dispose();
    _spo2Controller.dispose();
    _glucoseController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker', style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Heart Rate', _heartRateController),
              _buildTextField('SpO2', _spo2Controller),
              _buildTextField('Glucose', _glucoseController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _predictDisease,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Predict Disease'),
              ),
              const SizedBox(height: 20),
              if (_prediction != null)
                Text(
                  'Prediction: $_prediction',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
