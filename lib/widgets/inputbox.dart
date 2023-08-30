import 'package:flutter/material.dart';

InputDecoration inputTheme(
    BuildContext context, String hintText, String label, Icon prefix) {
  return InputDecoration(
    label: Text(label),
    prefixIcon: prefix,
    counterText: '',
    filled: true,
    fillColor: Theme.of(context).colorScheme.tertiaryContainer,
    border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent, width: .5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent, width: .75)),
    focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    hintText: hintText,
    prefixIconColor: Theme.of(context).colorScheme.secondaryContainer,
    labelStyle: Theme.of(context).textTheme.headlineMedium,
    hintStyle: Theme.of(context).textTheme.headlineMedium,
    helperStyle: Theme.of(context).textTheme.headlineMedium,
    errorStyle: Theme.of(context).textTheme.displayMedium,
  );
}
//--------------------------------------------------Doc--------------------------------------------------\\
/*
The provided code defines a function called `inputTheme` that returns an `InputDecoration` object. The `InputDecoration` object is used to customize the appearance of an input field in Flutter's Material Design.

Here's a breakdown of what the code does:

1. The code imports the `flutter/material.dart` package, which provides the necessary classes and widgets for building the user interface.

1. The `inputTheme` function is defined, which takes four parameters:

   - `BuildContext context`: The context of the widget that calls this function.
   - `String hintText`: The hint text displayed inside the input field when it is empty.
   - `String label`: The label text displayed above the input field.
   - `Icon prefix`: The icon displayed as a prefix inside the input field.

1. Inside the function body, an `InputDecoration` object is created and configured with various properties to define the appearance of the input field.

   - `label`: Sets the label text displayed above the input field.
   - `prefixIcon`: Sets the icon displayed as a prefix inside the input field.
   - `counterText`: Sets the counter text to an empty string.
   - `filled`: Specifies that the input field should be filled with a color.
   - `fillColor`: Sets the color to fill the input field. The color is obtained from the `tertiaryContainer` property of the current theme's color scheme.
   - `border`: Sets the border of the input field. It uses an `OutlineInputBorder` with a transparent color and a width of 0.5.
   - `enabledBorder`: Sets the border of the input field when it is enabled but not focused. It uses an `OutlineInputBorder` with a transparent color and a width of 0.75.
   - `focusedBorder`: Sets the border of the input field when it is focused. It uses an `OutlineInputBorder` with a transparent color and a width of 1.
   - `hintText`: Sets the hint text displayed inside the input field when it is empty.
   - `prefixIconColor`: Sets the color of the prefix icon. The color is obtained from the `secondaryContainer` property of the current theme's color scheme.
   - `labelStyle`: Sets the style of the label text. The style is obtained from the `headlineMedium` property of the current theme's text theme.
   - `hintStyle`: Sets the style of the hint text. The style is obtained from the `headlineMedium` property of the current theme's text theme.
   - `helperStyle`: Sets the style of the helper text. The style is obtained from the `headlineMedium` property of the current theme's text theme.
   - `errorStyle`: Sets the style of the error text. The style is obtained from the `displayMedium` property of the current theme's text theme.

1. The `inputTheme` function returns the configured `InputDecoration` object.

This code provides a reusable function to define a consistent input field appearance throughout the application by customizing various properties of the `InputDecoration`.
*/