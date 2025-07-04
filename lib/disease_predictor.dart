import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DiseasePredictor {
  late Interpreter _interpreter;
  late List<String> _labels;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('ml/model.tflite');

      // Load labels
      final labelsData = await rootBundle.loadString('assets/ml/labels.txt');
      _labels = labelsData.split('\n').map((e) => e.trim()).toList();
    } catch (e) {
      print("Failed to load model or labels: $e");
    }
  }

  Future<String> predict({
    required double heartRate,
    required double spo2,
    required double glucose,
  }) async {
    // Input tensor shape must be [1, 3] (if model expects 3 features)
    final input = [
      [heartRate, spo2, glucose]
    ];

    // Output should match label count: [1, number of classes]
    final output = List.generate(1, (_) => List.filled(_labels.length, 0.0));

    // Run inference
    _interpreter.run(input, output);

    // Find the index with highest confidence
    final predictionScores = output[0];
    int maxIndex = 0;
    double maxScore = predictionScores[0];

    for (int i = 1; i < predictionScores.length; i++) {
      if (predictionScores[i] > maxScore) {
        maxScore = predictionScores[i];
        maxIndex = i;
      }
    }

    return _labels[maxIndex];
  }
}
