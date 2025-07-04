// import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;

// class VoiceCommandScreen extends StatefulWidget {
//   const VoiceCommandScreen({super.key});

//   @override
//   State<VoiceCommandScreen> createState() => _VoiceCommandScreenState();
// }

// class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _spokenText = "Press the mic and start speaking...";

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize();
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(onResult: (val) {
//           setState(() {
//             _spokenText = val.recognizedWords;
//           });
//         });
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Voice Command"),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Text("Your Voice Input:", style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 20),
//             Text(_spokenText, style: const TextStyle(fontSize: 22)),
//             const SizedBox(height: 40),
//             FloatingActionButton(
//               onPressed: _listen,
//               backgroundColor: Colors.deepPurple,
//               child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
