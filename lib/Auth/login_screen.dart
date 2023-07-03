// import 'dart:io';
// import 'dart:ui';

import 'package:DrBalcony/Auth/AppleAuth.dart';
import 'package:DrBalcony/Auth/progressButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../firebase_options.dart';
//import 'package:flutter_loading_button/loading_button.dart';
import 'package:DrBalcony/Auth/button.dart';
import 'package:DrBalcony/Auth/resetPass.dart';
import 'package:DrBalcony/inputbox.dart';
import 'package:DrBalcony/webview.dart';
import 'package:DrBalcony/webviewUtils.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart' as ios;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final RoundedLoadingButtonController _btnController =
  //     RoundedLoadingButtonController();

  // void _doSomething() async {
  //   await signInWithGoogle();
  // }

  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  TextEditingController userName = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: loginAppbar(),
      // backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color.fromARGB(255, 255, 255, 255),
            //     Color.fromARGB(255, 189, 192, 202),
            //   ],
            // ),
            ),
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
            // Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       // Text('GET ALL SERVICE IN ONE PLACE',
            //       //     style: Theme.of(context).textTheme.headlineMedium),
            //     ]),
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
                      // Text('Email',
                      //     style: Theme.of(context).textTheme.headlineLarge
                      //     //  TextStyle(
                      //     //   color: Colors.black,
                      //     //   fontSize: 20,
                      //     //   fontWeight: FontWeight.bold,
                      //     // ),
                      //     ),
                      // const SizedBox(height: 10),
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //      crossAxisAlignment: CrossAxisAlignment.center,
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
                                    final validator = validateEmail(value!);
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
                            // (route) => false,
                          );

                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => ResetPassword(),
                          // ));
                        },
                        child: Text('Don\'t have an account yet? Sign Up',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      // Center(
                      //   child: ElevatedButton(
                      //       onPressed: () async {
                      //         if (_formKey.currentState!.validate()) {
                      //           var response = await sendAuthPostReq(
                      //               userName.text, Password.text);
                      //           if (response.isNotEmpty) {
                      //             if (response.first
                      //                 .startsWith("done")) {
                      //               var res = response.first.substring(
                      //                   4, response.first.length);
                      //               print(response);
                      //               await storage.write(
                      //                   key: 'username',
                      //                   value: userName.text);
                      //               await storage.write(
                      //                   key: 'password',
                      //                   value: Password.text);
                      //               await storage.write(
                      //                   key: 'token', value: res);
                      //               Navigator.of(context)
                      //                   .push(MaterialPageRoute(
                      //                 builder: (context) => WebView(
                      //                   webpage: RouterBalcony(
                      //                       response.last, res),
                      //                 ),
                      //               ));
                      //             } else if ((response.first
                      //                 .startsWith("fail"))) {
                      //               var res = response.first.substring(
                      //                   4, response.first.length);
                      //               ShowDialogBox(context, res);
                      //             }
                      //             print(response);
                      //           }
                      //         }
                      //       },
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text(
                      //           "log In",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 30,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       )
                      //       ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      LoadingBtn(
                        Widgets: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign In",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            // Icon(Icons.g),
                          ],
                        ),
                        //textStyle: Theme.of(context).textTheme.headlineMedium,
                        btnColor: Theme.of(context).colorScheme.primary,
                        name: "login",
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            var response = await sendAuthPostReq(
                                "regular", userName.text, Password.text, "");
                            if (response!.isNotEmpty) {
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
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(
                                //   builder: (context) => WebView(
                                //     webpage: RouterBalcony(
                                //         response.last, res),
                                //   ),
                                // )
                                // );
                              } else if ((response!.first.startsWith("fail"))) {
                                var res = response.first
                                    .substring(4, response.first.length);
                                ShowDialogBox(context, res, () {
                                  Navigator.of(context).pop();
                                }, "An error has occurred", false);
                              } else if ((response!.first.startsWith("noac"))) {
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
                          }
                        },
                      ),
                      // RoundedLoadingButton(
                      //   valueColor: Colors.white,
                      //   duration: Duration(microseconds: 500),
                      //   resetAfterDuration: true,
                      //   resetDuration:
                      //       userName.text.isNotEmpty && Password.text.isNotEmpty
                      //           ? Duration(seconds: 5)
                      //           : Duration(milliseconds: 150),
                      //   borderRadius: 10,
                      //   color: Theme.of(context).colorScheme.primary,
                      //   //failedIcon:IconData(),
                      //   child:
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text("Sign In",
                      //           style:
                      //               Theme.of(context).textTheme.displaySmall),
                      //       // Icon(Icons.g),
                      //     ],
                      //   ),
                      //   controller: _btnController,
                      //   onPressed: () async {
                      //     if (_formKey.currentState!.validate()) {
                      //       var response = await sendAuthPostReq(
                      //           "regular", userName.text, Password.text, "");
                      //       if (response.isNotEmpty) {
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
                      //           }, "An error has occurred");
                      //         }
                      //         print(response);
                      //       }
                      //     }
                      //   },
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text("Or",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                          ),
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
                      LoadingBtn(
                        Widgets: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: 30,
                                  child: Image.asset("assets/google.png")),
                            ),
                            // Icon(Icons.g),
                            Text("Sign in with Google",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                          ],
                        ),
                        //textStyle: Theme.of(context).textTheme.headlineMedium,
                        btnColor: Theme.of(context).colorScheme.tertiary,
                        name: "login",
                        onPressed: () async {
                          final token = await signInWithGoogle();
                          if (token != null && token.isNotEmpty) {
                            var response = await sendAuthPostReq(
                                "google", userName.text, Password.text, token);
                            if (response!.isNotEmpty) {
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
                                // Navigator.of(context)
                                //     .push(MaterialPageRoute(
                                //   builder: (context) => WebView(
                                //     webpage: RouterBalcony(
                                //         response.last, res),
                                //   ),
                                // )
                                // );
                              } else if ((response!.first.startsWith("fail"))) {
                                var res = response.first
                                    .substring(4, response.first.length);
                                ShowDialogBox(context, res, () {
                                  Navigator.of(context).pop();
                                }, "An error has occurred", false);
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
                          }
                        },
                      ),
                      // RoundedLoadingButton(
                      //   // animateOnTap: false,

                      //   valueColor: Theme.of(context).colorScheme.primary,
                      //   duration: Duration(microseconds: 500),
                      //   resetAfterDuration: true,
                      //   resetDuration: Duration(seconds: 5),
                      //   elevation: 5,
                      //   borderRadius: 10,
                      //   color: Theme.of(context).colorScheme.tertiary,
                      //   //failedIcon:IconData(),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Image.asset("assets/google.png"),
                      //       ),
                      //       // Icon(Icons.g),
                      //       Text("Sign in with Google",
                      //           style:
                      //               Theme.of(context).textTheme.headlineMedium),
                      //     ],
                      //   ),
                      //   controller: _btnController,
                      //   onPressed: () async {
                      //     final token = await signInWithGoogle();
                      //     if (token != null && token.isNotEmpty) {
                      //       var response = await sendAuthPostReq(
                      //           "google", userName.text, Password.text, token);
                      //       if (response.isNotEmpty) {
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
                      //           }, "An error has occurred");
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
                      // SizedBox(
                      //   height: 12,
                      // ),
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
                      // RoundedLoadingButton(
                      //   valueColor: Theme.of(context).colorScheme.primary,
                      //   duration: Duration(microseconds: 500),
                      //   resetAfterDuration: true,
                      //   resetDuration: Duration(seconds: 5),
                      //   elevation: 5,
                      //   borderRadius: 10,
                      //   color: Theme.of(context).colorScheme.tertiary,
                      //   //failedIcon:IconData(),
                      //   child: Row(
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
                      //   controller: _btnController,
                      //   onPressed: () async {
                      //     final token = await signInWithApple();
                      //     if (token != null && token.isNotEmpty) {
                      //       var response = await sendAuthPostReq(
                      //           "apple", userName.text, Password.text, token);
                      //       if (response.isNotEmpty) {
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
                      //           }, "An error has occurred");
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
                      //   ProgButton(onPressed: () {}, name: "sign in with google")
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     try {
                      //       final UserCredential userCredential =
                      //           await _signInWithGoogle();
                      //       // TODO: Handle successful sign-in.
                      //     } catch (e) {
                      //       print('Google Sign-In Error: $e');
                      //       // TODO: Handle sign-in error.
                      //     }
                      //     // try {
                      //     //   final UserCredential userCredential = await _signInWithGoogle();
                      //     //   // TODO: Handle successful sign-in.
                      //     // } catch (e) {
                      //     //   print('Google Sign-In Error: $e');
                      //     //   // TODO: Handle sign-in error.
                      //     // }
                      //   },
                      //   child: Text('Sign in with Google'),
                      // ),
                      // const SizedBox(height: 35),
                      // const Center(
                      //   child: Text(
                      //     '- Or Sign In with -',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => SecondScreen()));
                      //       },
                      //       child: Container(
                      //         width: 60,
                      //         height: 60,
                      //         padding: const EdgeInsets.all(5),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //           color: Colors.white38,
                      //         ),
                      //         child: Image.asset('assets/google.png'),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 50),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => SecondScreen()));
                      //       },
                      //       child: Container(
                      //         width: 60,
                      //         height: 60,
                      //         padding: const EdgeInsets.all(5),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //           color: Colors.white38,
                      //         ),
                      //         child: Image.asset('assets/facebook.png'),
                      //       ),
                      //     ),
                      //   ],
                      // )
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
