import 'package:DrBalcony/widgets/inputbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  CustomForm({
    required this.userNameController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Builder(
        builder: (BuildContext context) {
          if (Theme.of(context).platform == TargetPlatform.android) {
            return _buildCupertinoForm(context);
          } else {
            return _buildMaterialForm(context);
          }
        },
      ),
    );
  }

  Widget _buildCupertinoForm(BuildContext context) {
    return CupertinoFormSection(
      children: [
        CupertinoTextFormFieldRow(
          controller: userNameController,
          prefix: Icon(CupertinoIcons.person_solid),
          placeholder: "Username",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        CupertinoTextFormFieldRow(
          controller: passwordController,
          obscureText: true,
          prefix: Icon(CupertinoIcons.lock_fill),
          placeholder: "Password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          onEditingComplete: onSubmit,
        ),
      ],
    );
  }

  Widget _buildMaterialForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: userNameController,
          decoration: inputTheme(
              context, "Enter your UserName", "UserName", Icon(Icons.person)),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: inputTheme(
              context, "Enter your Password", "password", Icon(Icons.lock)),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          onEditingComplete: onSubmit,
        ),
      ],
    );
  }
}
//--------------------------------------------------Doc--------------------------------------------------\\
/*
This code defines a Flutter widget called `CustomForm` that represents a form with input fields for a username and password. The form can be rendered differently based on the platform (Android or iOS).

Here's a breakdown of what the code does:

- The code imports necessary dependencies, including `inputbox.dart` and Flutter's `material.dart` and `cupertino.dart` packages.

- The `CustomForm` class is defined, which extends `StatelessWidget`.

- The constructor of `CustomForm` is defined, which takes three required arguments: `userNameController` and `passwordController`, both of type `TextEditingController`, and `onSubmit`, a `VoidCallback` function.

- The `build` method is overridden to build the UI of the widget. It returns a `Theme` widget, which allows customizing the widget's appearance based on the current theme.

- Inside the `Theme` widget, a `Builder` widget is used to access the current `BuildContext`.

- Depending on the platform (Android or iOS), the `_buildCupertinoForm` or `_buildMaterialForm` method is called to render the appropriate form.

- The `_buildCupertinoForm` method returns a `CupertinoFormSection` widget, which represents a section of a form in Cupertino (iOS-style) design. It contains two `CupertinoTextFormFieldRow` widgets representing the input fields for the username and password. Each row includes properties like `controller`, `prefix`, `placeholder`, `keyboardType`, `textInputAction`, and `onEditingComplete` to configure the text form fields.

- The `_buildMaterialForm` method returns a `Column` widget, which displays the form in Material (Android-style) design. It contains two `TextFormField` widgets representing the input fields for the username and password. Each field includes properties like `controller`, `decoration`, `keyboardType`, `textInputAction`, `onEditingComplete`, and `obscureText` to configure the text form fields.

- The `inputTheme` function is used to define the decoration for the `TextFormField` widgets. It is assumed that the implementation of this function is defined in the `inputbox.dart` file.

The purpose of this code is to provide a customizable form widget that can be used to capture user input for a username and password. It adapts its appearance based on the platform, either using Cupertino-style form elements for iOS or Material-style form elements for Android.
*/