import 'dart:io';
import 'dart:ui';

import 'package:DrBalcony/Auth/login_screen.dart';
import 'package:DrBalcony/webview.dart';
import 'package:DrBalcony/webviewUtils.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:image_compare_slider/image_compare_slider.dart';
// import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  // Future<Uint8List> ImageCodec(String asset) async {
  //   ByteData imageData = await rootBundle.load(asset);
  //   Uint8List bytes = imageData.buffer.asUint8List();

  //   return bytes;
  // }

  @override
  Widget build(BuildContext context) {
    // final Uri url = Uri.parse('https://www.drbalcony.com');
    launchURL() async {
      var uri = Uri.parse("https://drbalcony.com");
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // can't launch url
      }
    }

    PreferredSizeWidget getAppbar() {
      if (Platform.isIOS) {
        return const ios.CupertinoNavigationBar(
          middle: ios.Text("DrBalcony"),
          // padding: EdgeInsetsDirectional.all(),
        );
      } else {
        return AppBar(
          toolbarHeight: 0,
        );
      }
    }

    var sw = MediaQuery.of(context).size.width;
    // var sh = MediaQuery.of(context).size.height;
    // var barheight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: getAppbar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color.fromARGB(255, 255, 255, 255),
            //     Color.fromARGB(255, 189, 192, 202),
            //   ],
            // ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 254, 255, 255),
                  Color.fromARGB(255, 184, 197, 209),
                ],
              ),
              // image: DecorationImage(
              //   colorFilter: ColorFilter.mode(
              //     Colors.white.withOpacity(0.0),
              //     BlendMode.lighten,
              //   ),
              //   image: AssetImage(
              //     "assets/newBalcony.jpg",
              //   ),
              //   alignment: Alignment.topRight,
              //   fit: BoxFit.cover,
              // ),
            ),
            // child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.black.withOpacity(0.3),
            //     ),
            //     // Add your child widgets here
            //   ),
            // ),
          ),
          SingleChildScrollView(
            //child: Container(
            // height: double.infinity,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //   image: AssetImage(
            //     "assets/balcony.jpg",
            //   ),

            //   //    height: double.infinity,
            //   alignment: Alignment.topLeft,
            //   fit: BoxFit.cover,
            // )),
            child: Transform.scale(
              scale: sw > 800 ? 1.2 : 1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                //crossAxisAlignment: ,
                children: [
                  // Image.asset(
                  //   "assets/balcony.jpg",
                  //   alignment: Alignment.topLeft,
                  //   fit: BoxFit.cover,
                  //   height: double.infinity,
                  // ),

                  // Container(
                  //     decoration: const BoxDecoration(
                  //         color: Color.fromARGB(255, 219, 219, 219)),
                  //     child: Padding(
                  //       padding: EdgeInsets.fromLTRB(10, 5 + barheight, 10, 5),
                  //       child: SizedBox(
                  //           width: sw,
                  //           height: sw / 8,
                  //           child:
                  //           Image.asset(
                  //             'assets/logo.png',
                  //             fit: BoxFit.contain,
                  //           )
                  //           ),
                  //     )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox( height: 20,),
                        // Text(
                        //   "GET ALL SERVICE IN ONE PLACE",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 40,
                        //       color: ios.Color.fromARGB(221, 227, 212, 196)),
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            width: sw < 800 ? sw / 1.5 : sw / 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                  //color: Color.fromARGB(173, 120, 181, 231),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                    //   width: sw < 800 ? sw / 1.5 : sw / 2,
                                    fit: BoxFit.fill,
                                    'assets/logo.png'),
                                //  Text(
                                //   "GET ALL SERVICE IN ONE PLACE",
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.w600,
                                //       fontSize: 20,
                                //       color: const Color.fromARGB(
                                //           255, 255, 255, 255)),
                                // ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            // width: sw < 800 ? sw / 1.5 : sw / 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                  // color: Color.fromARGB(174, 66, 164, 245),
                                  borderRadius: BorderRadius.only(
                                      // topLeft: Radius.circular(15),
                                      // topRight: Radius.circular(15)
                                      )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("GET ALL SERVICE IN ONE PLACE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                      //  TextStyle(
                                      //     fontWeight: FontWeight.w600,
                                      //     fontSize: 20,
                                      //     color: const Color.fromARGB(
                                      //         255, 255, 255, 255)),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            //width: sw < 800 ? sw / 1.5 : sw / 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                  // color: Color.fromARGB(174, 66, 164, 245),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Experience peace of mind with SB Inspection Services - Your trusted provider of SB721 and SB326 inspections in Southern California.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                              ),
                            ),
                          ),
                        ),
                        ios.Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ios.Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "After",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  Text(
                                    "Slide to Compare Our Work",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  ios.Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Before",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  )
                                ],
                              ),
                              ios.SizedBox(
                                child: ios.Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ImageCompareSlider(
                                    fillHandle: true,

                                    //dividerColor: Theme.of(context).colorScheme.primaryContainer,
                                    itemOne:
                                        Image.asset("assets/newBalcony.jpg"),
                                    itemTwo:
                                        Image.asset("assets/oldBalcony.png"),
                                  ),
                                ),
                              ),
                              ios.SizedBox(
                                width: sw / 1.5,
                                child: ios.Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: ios.CupertinoButton(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(ios.CupertinoPageRoute(
                                        builder: (context) {
                                          return LoginScreen();
                                        },
                                      ));
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (context) => WebView(
                                      //     webpage: RouterBalcony("newproject"),
                                      //   ),
                                      // ));
                                    },
                                    child: Text("Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  ),
                                ),
                              ),
                              ios.Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: ios.SizedBox(
                                  width: sw / 1.5,
                                  child: ios.CupertinoButton(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    onPressed: () async {
                                      String? apiAuth =
                                          await storage.read(key: 'apiAuth');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebView(
                                                  webpage: RouterBalcony(
                                                      apiAuth!, "register"),
                                                )),
                                        // (route) => false,
                                      );
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (context) => WebView(
                                      //     webpage: RouterBalcony("newproject"),
                                      //   ),
                                      // ));
                                    },
                                    child: Text("New Project",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                        //  TextStyle(
                                        //   fontSize: sw > 800 ? sw / 40 : sw / 25,
                                        //   color: Colors.black,
                                        // ),
                                        ),
                                  ),
                                ),
                              ),
                              // ios.SizedBox(
                              //   width: sw / 1.5,
                              //   child: ios.CupertinoButton(
                              //     color: Theme.of(context).colorScheme.secondary,
                              //     onPressed: launchURL,
                              //     child: Text("Website",
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .displaySmall),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // ios.Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child: Column(
                        //     children: [],
                        //   ),
                        // ),
                        // ios.Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child:
                        // )

                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
                        //   child: SizedBox(
                        //     width: sw > 800 ? sw / 4 : sw / 2,
                        //     child: ElevatedButton(
                        //       style: const ButtonStyle(
                        //         backgroundColor: MaterialStatePropertyAll<Color>(
                        //             Color.fromARGB(255, 255, 208, 0)),
                        //       ),
                        //       onPressed: () {
                        //         // Navigator.of(context).push(MaterialPageRoute(
                        //         //   builder: (context) => WebView(
                        //         //     webpage: RouterBalcony("newproject"),
                        //         //   ),
                        //         // ));
                        //       },
                        //       child: Text(
                        //         "New Project",
                        //         style: TextStyle(
                        //             fontSize: sw > 800 ? sw / 40 : sw / 25,
                        //             color: Colors.black),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: sw > 800 ? sw / 4 : sw / 2,
                        //     child: ElevatedButton(
                        //       onPressed: () {
                        //         // Navigator.of(context).push(MaterialPageRoute(
                        //         //   builder: (context) => WebView(
                        //         //     webpage: RouterBalcony("login"),
                        //         //   ),
                        //         // ));
                        //       },
                        //       child: Text("Login",
                        //           style: TextStyle(
                        //               fontSize: sw > 800 ? sw / 40 : sw / 25)),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: sw > 800 ? sw / 4 : sw / 2,
                        //     child: ElevatedButton(
                        //       onPressed: launchURL,
                        //       child: Text(
                        //         "Website",
                        //         style: TextStyle(
                        //           fontSize: sw > 800 ? sw / 40 : sw / 25,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //),
          ),
        ],
      ),
    );
  }
}
