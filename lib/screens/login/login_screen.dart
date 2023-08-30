import 'dart:io' show Platform;

import 'package:DrBalcony/screens/reset_password/resetPass.dart';
import 'package:DrBalcony/widgets/button.dart';
import 'package:DrBalcony/widgets/inputbox.dart';
import 'package:DrBalcony/screens/web_view/webview.dart';
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
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
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
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
                              Card(
                                color: Colors.transparent,
                                elevation: 3,
                                child: TextFormField(
                                  maxLength: 50,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).nextFocus(),
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
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  decoration: inputTheme(
                                      context,
                                      "Enter your UserName",
                                      "UserName",
                                      Icon(Icons.person)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                color: Colors.transparent,
                                elevation: 3,
                                child: TextFormField(
                                  maxLength: 100,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your Password";
                                    }
                                    return null;
                                  },
                                  controller: Password,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  decoration: inputTheme(
                                      context,
                                      "Enter your Password",
                                      "Password",
                                      Icon(Icons.lock)),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResetPassword(),
                          ));
                        },
                        child: Text('Forgot your Password?',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () async {
                          String? apiAuth = await storage.read(key: 'apiAuth');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebView(
                                      webpage:
                                          RouterBalcony(apiAuth!, "register"),
                                    )),
                          );
                        },
                        child: Text('Don\'t have an account yet? Sign Up',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),

                      LoadingBtn(
                        Widgets: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign In",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                          ],
                        ),
                        btnColor: Theme.of(context).colorScheme.primary,
                        name: "login",
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            var response = await sendAuthPostReq(
                                "regular", userName.text, Password.text, "");
                            if (response.isNotEmpty) {
                              if (response.first.startsWith("done")) {
                                var res = response.first
                                    .substring(4, response.first.length);
                                print(response);
                                await storage.write(
                                    key: 'username', value: userName.text);
                                await storage.write(
                                    key: 'password', value: Password.text);
                                await storage.write(key: 'token', value: res);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebView(
                                            webpage: RouterBalcony(
                                                response.last, res),
                                          )),
                                  (route) => false,
                                );
                              } else if ((response.first.startsWith("fail"))) {
                                var res = response.first
                                    .substring(4, response.first.length);
                                ShowDialogBox(context, res, () {
                                  Navigator.of(context).pop();
                                }, "An error has occurred", false);
                              } else if ((response.first.startsWith("noac"))) {
                                // await signOutGoogle();
                                String? apiAuth =
                                    await storage.read(key: 'apiAuth');
                                var res = response.first
                                    .substring(4, response.first.length);
                                ShowDialogBox(context,
                                    "Click here to create account with ${userName.text}",
                                    () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebView(
                                              webpage: RouterBalcony(
                                                  apiAuth!, "register"),
                                            )),
                                  );
                                }, res, true);
                              }
                              print(response);
                            }
                          }
                        },
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Platform.isAndroid
                              ? Center(
                                  child: Text("Or",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                )
                              : Container(),
                          //  Icon(Icons.g),
                        ],
                      ),
                      // SubmitButton(
                      //     onPressed: () async {
                      //       final GoogleSignIn googleSignIn = GoogleSignIn(
                      //         scopes: [
                      //           'email',
                      //           'https://drbalcony.site/customer/login/googleOAuthResponse',
                      //         ],
                      //         // clientId:
                      //         //     '804309542048-t1id70gdkgfndt8mt41shnk6vvrab4ql.apps.googleusercontent.com',
                      //       );

                      //       final GoogleSignInAccount? googleSignInAccount =
                      //           await googleSignIn.signIn();

                      //       final GoogleSignInAuthentication googleAuth =
                      //           await googleSignInAccount!.authentication;
                      //       final String accessToken = googleAuth.accessToken!;
                      //     },
                      //     name: "Sign in with google"),
                      // RoundedLoadingButton(
                      //   child: Text("Login",
                      //       style: TextStyle(color: Colors.white)),
                      //   controller: _btnController,
                      //   onPressed: () async {
                      //     final token = await signInWithGoogle();
                      //     if (token != null) {
                      //       String? apiAuth =
                      //           await storage.read(key: 'apiAuth');
                      //       Navigator.of(context).pushAndRemoveUntil(
                      //           MaterialPageRoute(
                      //               builder: (context) => WebView(
                      //                     webpage:
                      //                         RouterBalcony(apiAuth!, token),
                      //                   )),
                      //           (route) => false);
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      // LoadingButton(
                      //   // This needs to be async
                      //   onPressed: () async {
                      //     await Future.delayed(
                      //       const Duration(seconds: 3),
                      //       () => print('Task done!'),
                      //     );
                      //   },
                      //   child: const Text('Button'),
                      //   loadingWidget: Center(child: const Text('waiting')),
                      // ),
                      Platform.isAndroid
                          ? LoadingBtn(
                              Widgets: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: 30,
                                        child:
                                            Image.asset("assets/google.png")),
                                  ),
                                  // Icon(Icons.g),
                                  Text("Sign in with Google",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ],
                              ),
                              //textStyle: Theme.of(context).textTheme.headlineMedium,
                              btnColor: Theme.of(context).colorScheme.tertiary,
                              name: "login",
                              onPressed: () async {
                                final token = await signInWithGoogle();
                                if (token != null && token.isNotEmpty) {
                                  var response = await sendAuthPostReq("google",
                                      userName.text, Password.text, token);
                                  if (response.isNotEmpty) {
                                    if (response.first.startsWith("done")) {
                                      var res = response.first
                                          .substring(4, response.first.length);
                                      print(response);
                                      await storage.write(
                                          key: 'username',
                                          value: userName.text);
                                      await storage.write(
                                          key: 'password',
                                          value: Password.text);
                                      await storage.write(
                                          key: 'token', value: res);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebView(
                                                  webpage: RouterBalcony(
                                                      response.last, res),
                                                )),
                                        (route) => false,
                                      );
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => WebView(
                                      //     webpage: RouterBalcony(
                                      //         response.last, res),
                                      //   ),
                                      // )
                                      // );
                                    } else if ((response.first
                                        .startsWith("fail"))) {
                                      var res = response.first
                                          .substring(4, response.first.length);
                                      ShowDialogBox(context, res, () {
                                        Navigator.of(context).pop();
                                      }, "An error has occurred", false);
                                    } else if ((response.first
                                        .startsWith("noac"))) {
                                      // await signOutGoogle();

                                      String? apiAuth =
                                          await storage.read(key: 'apiAuth');
                                      var res = response.first
                                          .substring(4, response.first.length);
                                      ShowDialogBox(context,
                                          "Click here to create account with ${userName.text}",
                                          () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WebView(
                                                    webpage: RouterBalcony(
                                                        apiAuth!, "register"),
                                                  )),
                                          // (route) => false,
                                        );
                                      }, res, true);
                                      // ShowDialogBox(context, res, () {
                                      //   Navigator.of(context).pop();
                                      // }, "An error has occurred", false);
                                    }

                                    print(response);
                                  }

                                  // String? apiAuth =
                                  //     await storage.read(key: 'apiAuth');
                                  // Navigator.of(context).pushAndRemoveUntil(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => WebView(
                                  //               webpage:
                                  //                   RouterBalcony(apiAuth!, token),
                                  //             )),
                                  //     (route) => false);
                                } else if (token != null && token.isNotEmpty) {
                                  await signOutGoogle();
                                }
                              },
                            )
                          : Container(),

                      // LoadingBtn(
                      //   Widgets: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Image.asset("assets/apple.png"),
                      //       ),
                      //       // Icon(Icons.g),
                      //       Text("Sign in with Apple",
                      //           style:
                      //               Theme.of(context).textTheme.headlineMedium),
                      //     ],
                      //   ),
                      //   //textStyle: Theme.of(context).textTheme.headlineMedium,
                      //   btnColor: Theme.of(context).colorScheme.tertiary,
                      //   name: "login",
                      //   onPressed: () async {
                      //     final token = await signInWithApple();
                      //     if (token != null && token.isNotEmpty) {
                      //       var response = await sendAuthPostReq(
                      //           "apple", userName.text, Password.text, token);
                      //       if (response!.isNotEmpty) {
                      //         if (response.first.startsWith("done")) {
                      //           var res = response.first
                      //               .substring(4, response.first.length);
                      //           print(response);
                      //           await storage.write(
                      //               key: 'username', value: userName.text);
                      //           await storage.write(
                      //               key: 'password', value: Password.text);
                      //           await storage.write(key: 'token', value: res);
                      //           Navigator.pushAndRemoveUntil(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => WebView(
                      //                       webpage: RouterBalcony(
                      //                           response.last, res),
                      //                     )),
                      //             (route) => false,
                      //           );
                      //           // Navigator.of(context)
                      //           //     .push(MaterialPageRoute(
                      //           //   builder: (context) => WebView(
                      //           //     webpage: RouterBalcony(
                      //           //         response.last, res),
                      //           //   ),
                      //           // )
                      //           // );
                      //         } else if ((response.first.startsWith("fail"))) {
                      //           var res = response.first
                      //               .substring(4, response.first.length);
                      //           ShowDialogBox(context, res, () {
                      //             Navigator.of(context).pop();
                      //           }, "An error has occurred", false);
                      //         }
                      //         print(response);
                      //       }

                      //       // String? apiAuth =
                      //       //     await storage.read(key: 'apiAuth');
                      //       // Navigator.of(context).pushAndRemoveUntil(
                      //       //     MaterialPageRoute(
                      //       //         builder: (context) => WebView(
                      //       //               webpage:
                      //       //                   RouterBalcony(apiAuth!, token),
                      //       //             )),
                      //       //     (route) => false);
                      //     }
                      //   },
                      // ),
                    ],
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
Here's what the code is doing:

1. Imports necessary packages - like platform check, auth widgets, input widgets etc.

1. Defines LoginScreen stateful widget class

1. Inside LoginScreenState class:

- Initializes form key and secure storage

- Sets up text controllers for username and password

- build method:

  - Gets screen width

  - Returns Scaffold with:

    - AppBar

    - Column body with:

      - Logo image

      - Form with username and password fields

      - Login button

      - Forgot password button

      - Sign up link

      - Login buttons for regular login, Google, Apple etc

- Handles form submission and authentication process

- Navigates to WebView on successful login

So in summary:

- It builds the login screen UI with form
- Handles login form submission
- Makes API call to authenticate credentials
- Navigates to webview on success
- Also includes Google/Apple login buttons

Let me know if any part needs more explanation!

*/