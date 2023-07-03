import 'dart:io';
import 'dart:ui';

import 'package:DrBalcony/webviewUtils.dart';
import 'package:DrBalcony/Auth/button.dart';
import 'package:DrBalcony/Auth/login_screen.dart';
import 'package:DrBalcony/inputbox.dart';
import 'package:DrBalcony/webview.dart';
import 'package:DrBalcony/webviewUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as ios;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();
  // final RoundedLoadingButtonController _btnController =
  //     RoundedLoadingButtonController();
  TextEditingController userName = TextEditingController();
  TextEditingController Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: loginAppbar(),
      // backgroundColor: Colors.white,
      body: Container(
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
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //     textAlign: TextAlign.center,
            //     'Experience peace of mind\n with SB Inspection Services',
            //     style: Theme.of(context).textTheme.headlineMedium),
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
              width: double.infinity,
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(147, 0, 77, 184).withOpacity(0.2),
              //   // image:
              //   //  DecorationImage(
              //   //   fit: BoxFit.cover,
              //   //   colorFilter: ColorFilter.mode(
              //   //     Colors.black.withOpacity(0.4),
              //   //     BlendMode.darken,
              //   //   ),
              //   //   image: AssetImage('assets/newBalcony.jpg'),
              //   //   // colorFilter:
              //   //   //     ColorFilter.mode(Colors.grey, BlendMode.colorBurn)
              //   // ),
              //   // image: DecorationImage(
              //   //   fit: BoxFit.fitHeight,

              //   //   image: AssetImage('assets/newBalcony.jpg'),
              //   //   // colorFilter:
              //   //   //     ColorFilter.mode(Colors.grey, BlendMode.colorBurn)
              //   // ),
              //   //  color: Colors.black12,
              //   borderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(5),
              //     topRight: Radius.circular(120),
              //   ),
              // ),
              child: Container(
                //decoration: BoxDecoration(),
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
                                      final validator = validateEmail(value!);
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
                                // TextFormField(
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "Please enter your Password";
                                //     }
                                //     return null;
                                //   },
                                //   controller: Password,
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headlineSmall,
                                //   decoration: inputTheme(context,
                                //       "Enter your Password", "Password"),
                                // ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        // TextButton(
                        //   onPressed: () {

                        //   },
                        //   child: Text('Forgot your Password?',
                        //       style:
                        //           Theme.of(context).textTheme.titleLarge),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
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

                                    // await storage.write(
                                    //     key: 'username',
                                    //     value: userName.text);
                                    // await storage.write(
                                    //     key: 'password',
                                    //     value: Password.text);
                                    // await storage.write(
                                    //     key: 'token', value: res);
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
                                  }
                                  print(response);
                                }
                              }
                            },
                          ),
                          // child: RoundedLoadingButton(
                          //   duration: Duration(microseconds: 500),
                          //   resetAfterDuration: true,
                          //   resetDuration: userName.text.isNotEmpty &&
                          //           Password.text.isNotEmpty
                          //       ? Duration(seconds: 5)
                          //       : Duration(milliseconds: 150),
                          //   borderRadius: 10,
                          //   color: Theme.of(context).colorScheme.primary,
                          //   //failedIcon:IconData(),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text("Reset Password",
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .displaySmall),
                          //       // Icon(Icons.g),
                          //     ],
                          //   ),
                          //   controller: _btnController,
                          //   onPressed: () async {
                          //     if (_formKey.currentState!.validate()) {
                          //       var response = await forgetpass(
                          //         userName.text,
                          //       );
                          //       if (response.isNotEmpty) {
                          //         if (response.first.startsWith("done")) {
                          //           var res = response.first
                          //               .substring(4, response.first.length);
                          //           print(response);
                          //           ShowDialogBox(context, res, () {
                          //             Navigator.pushAndRemoveUntil(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       LoginScreen()),
                          //               (route) => false,
                          //             );
                          //           }, "Success");

                          //           // await storage.write(
                          //           //     key: 'username',
                          //           //     value: userName.text);
                          //           // await storage.write(
                          //           //     key: 'password',
                          //           //     value: Password.text);
                          //           // await storage.write(
                          //           //     key: 'token', value: res);
                          //           // Navigator.of(context)
                          //           //     .push(MaterialPageRoute(
                          //           //   builder: (context) => WebView(
                          //           //     webpage: RouterBalcony(
                          //           //         response.last, res),
                          //           //   ),
                          //           // )
                          //           // );
                          //         } else if ((response.first
                          //             .startsWith("fail"))) {
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
                        ),
                        const SizedBox(height: 35),
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
                        const SizedBox(height: 20),
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
              ),
            ))
          ],
        ),
      ),
    );
  }
}
