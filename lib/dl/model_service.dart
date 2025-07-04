// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';

// class ModelService {
//   late Interpreter _interpreter;

//   Future<void> loadModel() async {
//     try {
//       _interpreter = await Interpreter.fromAsset('models/symptom_model.tflite');
//       if (kDebugMode) {
//         print("✅ Model loaded");
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("❌ Error loading model: $e");
//       }
//     }
//   }

//   List<double> runPrediction(List<double> inputSymptoms) {
//     var output = List.filled(1 * 8, 0).reshape([1, 8]); // Change 8 if needed
//     _interpreter.run([inputSymptoms], output);
//     return output[0].cast<double>();
//   }
// }
