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
//--------------------------------------------------Doc--------------------------------------------------\\
/*
Here's what the key parts of this LoadingBtn widget are doing:

1. LoadingBtn is a StatefulWidget to track loading state

1. It takes relevant props like onPressed callback, button text/widget etc.

1. The state class (\_LoadingBtnState) has a bool (\_isLoading) to track loading state

1. In build(), it returns a Padded ElevatedButton with:

- Dynamically set width, height based on screen size

- Background color from prop

- Child based on loading state:

  - If loading, shows "Loading" text

  - Else shows widget passed in prop

5. The key part is the \_onPressed method:

- Sets \_isLoading to true to show loading

- Starts a 1 second Timer

- Calls the onPressed callback passed in

- After timer ends, sets \_isLoading back to false

So in summary:

- It creates a customizable loading button widget

- Handles internally tracking loading state

- Shows a loading indicator for 1 sec on press

- Calls the actual callback after load ends

This allows easily adding a loading overlay to any button click action in a reusable way. The state management and indicators are handled internally.
*/