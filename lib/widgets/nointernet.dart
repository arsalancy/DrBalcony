import 'package:DrBalcony/screens/get_start/getStart.dart';
import 'package:DrBalcony/screens/web_view/webview.dart';
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Nointernet extends StatelessWidget {
  const Nointernet({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 233, 237, 241),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/nowifi.png"),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                textAlign: TextAlign.center,
                "There Is No Internet Connection",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color.fromARGB(255, 41, 0, 0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                textAlign: TextAlign.center,
                "Please Check Your Internet Connection And Try Again.",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color.fromARGB(255, 41, 0, 0)),
              ),
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: () async {
                  String? apiAuth = await storage.read(key: 'apiAuth');
                  String? token = await storage.read(key: 'token');

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (apiAuth != null && token != null)
                            ? WebView(
                                webpage: RouterBalcony(apiAuth, token),
                              )
                            : GetStart()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Try Again",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//--------------------------------------------------Doc--------------------------------------------------\\
/*
this code defines a Flutter StatelessWidget called Nointernet. This widget represents a screen that is displayed when there is no internet connection. Here's what the code does:

Imports: The code imports various Dart packages and local files required for the functionality implemented in the code. These imports include package:DrBalcony/getStart.dart, package:DrBalcony/webview.dart, package:DrBalcony/webviewUtils.dart, and package:flutter/material.dart. These packages and files are necessary for defining the Flutter widgets and accessing resources.

Nointernet class: This class extends StatelessWidget and represents the UI for the "No Internet Connection" screen.

Constructor: The Nointernet class has a default constructor that takes no arguments.

build method: This method overrides the build method of the StatelessWidget class. It builds and returns the widget tree for the "No Internet Connection" screen.

FlutterSecureStorage: An instance of FlutterSecureStorage is created to allow secure storage access.

Scaffold: The root widget of the screen is a Scaffold widget, which provides a basic structure for the screen.

body: The body property of the Scaffold widget defines the main content of the screen. It consists of a Container widget that centers its child widgets vertically and horizontally.

Column: The Column widget is used to vertically stack multiple child widgets.

Child widgets:
Image.asset: An image widget that displays an image from the assets folder. The image path is "assets/nowifi.png".

Padding with Text: A Padding widget wraps a Text widget to add padding around it. It displays a text message indicating the absence of internet connection.

Padding with Text: Another Padding widget with a Text widget, displaying a message instructing the user to check their internet connection.

SizedBox with ElevatedButton: A SizedBox widget sets the width of its child, and it contains an ElevatedButton widget. This button is used to try connecting again when clicked.

onPressed: The onPressed property of the ElevatedButton is set to an asynchronous function that gets the stored apiAuth and token values from secure storage using FlutterSecureStorage. Based on the values, it navigates to either a WebView widget with RouterBalcony(apiAuth, token) as its argument or the GetStart widget.

child: The child property of the ElevatedButton is a Text widget that displays the text "Try Again".

The Nointernet widget is used to display a user-friendly screen when there is no internet connection. It provides an option for the user to try connecting again by tapping the "Try Again" button.
*/