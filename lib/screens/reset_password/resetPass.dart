import 'package:DrBalcony/screens/login/login_screen.dart';
import 'package:DrBalcony/widgets/button.dart';
import 'package:DrBalcony/widgets/inputbox.dart';
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  TextEditingController userName = TextEditingController();
  TextEditingController Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: loginAppbar(),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                  width: sw < 800 ? sw / 1.5 : sw / 4,
                  fit: BoxFit.contain,
                  'assets/logo.png'),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enter your email to send an email containing the new password.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  color: Colors.transparent,
                                  elevation: 3,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your Email";
                                      }
                                      final validator = validateEmail(value);
                                      if (validator != "done") {
                                        return validator;
                                      }
                                      return null;
                                    },
                                    controller: userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    decoration: inputTheme(
                                        context,
                                        "Enter your UserName",
                                        "UserName",
                                        Icon(Icons.person)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: LoadingBtn(
                            Widgets: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Reset Password",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                // Icon(Icons.g),
                              ],
                            ),
                            //textStyle: Theme.of(context).textTheme.headlineMedium,
                            btnColor: Theme.of(context).colorScheme.primary,
                            name: "Reset Password",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var response = await forgetpass(
                                  userName.text,
                                );
                                if (response.isNotEmpty) {
                                  if (response.first.startsWith("done")) {
                                    var res = response.first
                                        .substring(4, response.first.length);
                                    print(response);
                                    ShowDialogBox(context, res, () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (route) => false,
                                      );
                                    }, "Success", false);
                                  } else if ((response.first
                                      .startsWith("fail"))) {
                                    var res = response.first
                                        .substring(4, response.first.length);
                                    ShowDialogBox(context, res, () {
                                      Navigator.of(context).pop();
                                    }, "An error has occurred", false);
                                  }
                                  print(response);
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 35),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
//--------------------------------------------------Doc--------------------------------------------------\\
/*
This code represents a Flutter widget called `ResetPassword`, which is a screen for resetting a user's password. The screen includes a form where the user can enter their email to receive an email containing the new password.

Here's a breakdown of what the code does:

- The code imports necessary dependencies, including `webviewUtils.dart`, `button.dart`, `login_screen.dart`, `inputbox.dart`, and Flutter's `material.dart` package.

- The `ResetPassword` class is defined, which extends `StatefulWidget`.

- The constructor of `ResetPassword` is defined, which takes no arguments.

- The `_ResetPasswordState` class is defined, which extends `State<ResetPassword>`. It represents the state associated with the `ResetPassword` widget.

- Inside the `_ResetPasswordState` class, a `_formKey` of type `GlobalKey<FormState>` is defined. This key is used to identify and validate the form.

- An instance of `FlutterSecureStorage` is created to handle secure storage operations.

- `TextEditingController` instances, `userName` and `Password`, are created to handle the input fields for the username and password.

- The `build` method is overridden to build the UI of the widget. It returns a `Scaffold` widget that provides the basic screen structure.

- The `appBar` property of the `Scaffold` is set to `loginAppbar()`, which is assumed to be a custom app bar widget defined elsewhere.

- The `body` property of the `Scaffold` is set to a `Container` widget containing the main content of the screen.

- Inside the `Container`, a `Column` widget is used to arrange the child widgets vertically.

- The first child of the `Column` is an `Image.asset` widget that displays an image logo. The size of the image is adjusted based on the screen width.

- The second child of the `Column` is an `Expanded` widget containing the form elements.

- Inside the `Expanded` widget, a `Container` widget is used to provide padding and constraints to the contents.

- The contents of the `Container` are wrapped in a `SingleChildScrollView` to enable scrolling if the content overflows.

- Inside the `SingleChildScrollView`, the form elements are arranged using `Column` and `Form` widgets. The email input field is wrapped in a `Card` widget for styling purposes.

- A `LoadingBtn` widget is used to display a button for resetting the password. The button triggers a validation check and calls the `forgetpass` function to initiate the password reset process.

- A `ShowDialogBox` function is called to display a dialog box with a success or error message based on the response from the `forgetpass` function.

The purpose of this code is to provide a screen where users can enter their email to initiate the password reset process. It handles form validation, makes an API call to reset the password, and displays the appropriate feedback to the user.
*/