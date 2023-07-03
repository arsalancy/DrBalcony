// import 'package:dr_balcony/webviewUtils.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';
// // import 'package:progress_state_button/progress_button.dart';

// class ProgButton extends StatefulWidget {
//   final VoidCallback onPressed;
//   final String name;
//   const ProgButton({super.key, required this.onPressed, required this.name});

//   @override
//   State<ProgButton> createState() => _ProgButtonState();
// }

// class _ProgButtonState extends State<ProgButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ProgressButton.icon(
//         iconedButtons: {
//           ButtonState.idle: IconedButton(
//               text: widget.name,
//               icon: Icon(Icons.send, color: Colors.white),
//               color: Colors.deepPurple.shade500),
//           ButtonState.loading:
//               IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
//           ButtonState.fail: IconedButton(
//               text: "Failed",
//               icon: Icon(Icons.cancel, color: Colors.white),
//               color: Colors.red.shade300),
//           ButtonState.success: IconedButton(
//               text: "Success",
//               icon: Icon(
//                 Icons.check_circle,
//                 color: Colors.white,
//               ),
//               color: Colors.green.shade400)
//         },
//         onPressed: () async {
//           signInWithGoogle();
//         },
//         state: ButtonState.idle);
//   }
// }
