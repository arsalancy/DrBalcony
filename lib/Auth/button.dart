// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// class SubmitButton extends StatefulWidget {
//   final VoidCallback onPressed;
//   final String name;

//   SubmitButton({required this.onPressed, required this.name});

//   @override
//   _SubmitButtonState createState() => _SubmitButtonState();
// }

// class _SubmitButtonState extends State<SubmitButton>
//     with SingleTickerProviderStateMixin {
//   bool _clicked = false;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   double _buttonWidth = double.infinity;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//   }

//   void _handleButtonPress() {
//     setState(() {
//       _clicked = true;
//       _buttonWidth = 50.0;
//     });

//     // Show circular progress bar
//     _controller.repeat();

//     // Call the onPressed callback after a delay to simulate an asynchronous operation
//     Future.delayed(Duration(seconds: 2), () {
//       widget.onPressed();
//       // Hide circular progress bar
//       _controller.stop();
//       setState(() {
//         _clicked = false;
//         _buttonWidth = double.infinity;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).platform;

//     if (_clicked) {
//       if (theme == TargetPlatform.iOS) {
//         return CupertinoButton(
//           padding: EdgeInsets.zero,
//           onPressed: () {},
//           child: Container(
//             height: 50,
//             width: _buttonWidth,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               color: CupertinoColors.activeBlue,
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CupertinoActivityIndicator(
//                 radius: 20,
//                 animating: true,
//               ),
//             ),
//           ),
//         );
//       } else {
//         return Container(
//           height: 50,
//           width: _buttonWidth,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             color: Colors.blue,
//           ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 34,
//                   width: 34,
//                   child: CircularProgressIndicator(
//                     value: _animation.value,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   widget.name,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//     } else {
//       if (theme == TargetPlatform.iOS) {
//         return CupertinoButton(
//           padding: EdgeInsets.zero,
//           onPressed: _handleButtonPress,
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               color: CupertinoColors.activeBlue,
//             ),
//             child: Center(
//               child: Text(
//                 widget.name,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         );
//       } else {
//         return Material(
//           color: Colors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(25),
//             onTap: _handleButtonPress,
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 color: Colors.blue,
//               ),
//               child: Center(
//                 child: Text(
//                   widget.name,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';

class LoadingBtn extends StatefulWidget {
  final Function onPressed;
  final String name;
  final Color btnColor;
  final Row Widgets;
  const LoadingBtn(
      {required this.onPressed,
      required this.name,
      required this.btnColor,
      required this.Widgets});

  @override
  _LoadingBtnState createState() => _LoadingBtnState();
}

class _LoadingBtnState extends State<LoadingBtn> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: sw / 1.2,
          height: sw < 600 ? sw / 8 : sw / 12,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                backgroundColor: widget.btnColor,
              ),
              onPressed: _isLoading ? null : _onPressed,
              child: _isLoading ? Text("Loading") : widget.Widgets
              // : Text(
              //     widget.name,
              //     style: widget.textStyle,
              //   ),
              ),
        ),
      ),
    );
  }

  void _onPressed() {
    setState(() {
      _isLoading = true;
    });

    Timer(Duration(seconds: 1), () {
      widget.onPressed();

      setState(() {
        _isLoading = false;
      });
    });
  }
}
