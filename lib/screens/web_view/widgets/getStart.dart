import 'dart:io';
import 'dart:ui';

import 'package:DrBalcony/screens/login/login_screen.dart';
import 'package:DrBalcony/screens/web_view/webview.dart';
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';

import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:image_compare_slider/image_compare_slider.dart';

import 'package:url_launcher/url_launcher.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    launchURL() async {
      var uri = Uri.parse("https://drbalcony.com");
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {}
    }

    PreferredSizeWidget getAppbar() {
      if (Platform.isIOS) {
        return const ios.CupertinoNavigationBar(
          middle: ios.Text("DrBalcony"),
        );
      } else {
        return AppBar(
          toolbarHeight: 0,
        );
      }
    }

    var sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: getAppbar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 254, 255, 255),
                  Color.fromARGB(255, 184, 197, 209),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: SizedBox(
                          width: sw < 800 ? sw / 1.5 : sw / 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  fit: BoxFit.fill, 'assets/logo.png'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: SizedBox(
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only()),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text("GET ALL SERVICE IN ONE PLACE",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: SizedBox(
                          child: Container(
                            decoration: const BoxDecoration(
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ios.Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "After",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                )
                              ],
                            ),
                            ios.Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ImageCompareSlider(
                                fillHandle: true,
                                itemOne: Image.asset("assets/newBalcony.jpg"),
                                itemTwo: Image.asset("assets/oldBalcony.png"),
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
                                    );
                                  },
                                  child: Text("New Project",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            //),
          ),
        ],
      ),
    );
  }
}
//--------------------------------------------------Doc--------------------------------------------------\\
/*
This code It represents the `GetStart` widget, which is a screen or page in the application. Here's a breakdown of what the code does:

1. Imports:

   - The code imports various dependencies and libraries, including `dart:io`, `dart:ui`, `package:flutter/cupertino.dart`, `package:flutter/material.dart`, and `package:url_launcher/url_launcher.dart`. These imports provide access to necessary classes and functions for building the Flutter application.

1. `GetStart` class:

   - This class extends `StatelessWidget`, indicating that it represents an immutable widget.
   - The class defines the `build` method, which is responsible for building the UI of the widget.

1. `launchURL` function:

   - This function is used to launch a URL. It utilizes the `url_launcher` package to open the URL in an external application.
   - It checks if the URL can be launched and then calls the `launchUrl` function to open the URL.

1. `getAppbar` function:

   - This function returns the app bar widget based on the platform. If the platform is iOS, it returns a `CupertinoNavigationBar`, and if it's not iOS, it returns an empty `AppBar`.

1. `build` method:

   - The `build` method is responsible for constructing the UI of the `GetStart` widget.
   - It returns a `Scaffold` widget that provides the basic layout structure for the screen.
   - The `appBar` property is set to the result of the `getAppbar` function, which determines the platform-specific app bar.
   - The `body` property contains a `Stack` widget that allows overlaying multiple widgets on top of each other.
   - Inside the `Stack`, there's a `Container` with a gradient background and a `SingleChildScrollView` that contains the main content of the screen.
   - The main content includes various `Padding`, `Column`, and `Row` widgets that arrange and display different UI elements such as images, text, buttons, and the `ImageCompareSlider` widget.

The code represents the UI and functionality of a screen in a Flutter application. It displays images, text, and buttons, and provides navigation to other screens or external websites.
*/