// import 'model_service.dart';

// class HealthPredictor {
//   final ModelService _modelService = ModelService();

//   Future<String> predictDisease(List<double> symptoms) async {
//     await _modelService.loadModel();

//     List<double> prediction = _modelService.runPrediction(symptoms);
//     int maxIndex =
//         prediction.indexOf(prediction.reduce((a, b) => a > b ? a : b));

//     List<String> labels = [
//       'Flu',
//       'Typhoid',
//       'Common Cold',
//       'COVID-19',
//       'Malaria',
//       'Normal',
//       'Dengue',
//       'Other' // <-- Add if needed
//     ];

//     return labels[maxIndex];
//   }
// }
