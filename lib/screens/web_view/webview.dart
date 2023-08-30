import 'dart:convert';

import 'package:DrBalcony/widgets/FileCampicker.dart';
import 'package:DrBalcony/screens/login/login_screen.dart';
import 'package:DrBalcony/screens/get_start/getStart.dart';
import 'package:DrBalcony/widgets/nointernet.dart';
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:io' show Platform;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:flutter/cupertino.dart' as ios;
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';

class WebView extends StatefulWidget {
  final RouterBalcony webpage;
  const WebView({Key? key, required this.webpage}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final selectedIndex = ValueNotifier<int>(0);
  final bnb = ValueNotifier<bool>(false);
  final firstTimeLoad = ValueNotifier<bool>(true);
  final currentUrL = ValueNotifier<String>('');
  final counterSelectedout = ValueNotifier<int>(0);
  final selectedout = ValueNotifier<bool>(false);
  late final WebViewController _controller;
  final ImagePicker picker = ImagePicker();
  final storage = FlutterSecureStorage();
  final tokener = ValueNotifier<String>('');
  late final PlatformWebViewControllerCreationParams params;
  List<BottomNavigationBarItem> barItems = [
    const BottomNavigationBarItem(
      icon: ios.Icon(Icons.work_rounded),
      label: 'Projects',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle_rounded),
      label: 'Profile',
    ),
  ];

//functions
  void onItemTapped(int index) async {
    selectedIndex.value = index;
    if (selectedIndex.value == 0) {
      sendMessage("Projects");
    }
    if (selectedIndex.value == 1) {
      sendMessage("Profile");
    }
  }

  PreferredSizeWidget getAppbar() {
    if (Platform.isAndroid) {
      return ios.CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(bottom: 2),
        leading: ios.CupertinoButton(
          child: ios.Icon(color: Colors.grey[700], Icons.menu),
          onPressed: () {},
        ),
        trailing: PopupMenuButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
                  .copyWith(topRight: Radius.circular(0))),
          color: Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black45)],
                color: Colors.white,
                shape: BoxShape.circle),
            child: Icon(
              Icons.more_horiz_rounded,
              color: Colors.grey,
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  onTap: () async {
                    signoutHandel(widget.webpage.token, context);
                  },
                  value: 'Sign out',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 20,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign out',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider()
                    ],
                  )),
            ];
          },
        ),
      );
    } else {
      return AppBar(
        leading: IconButton(
            onPressed: () {
              sendMessage('OpenDrawer');
            },
            icon: const Icon(Icons.menu)),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topRight: Radius.circular(0))),
            color: Colors.grey.shade100,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 33, 149, 243),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.more_vert_rounded,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () async {
                      signoutHandel(widget.webpage.token, context);
                    },
                    value: 'Sign out',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 20,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Sign out',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    )),
              ];
            },
          ),
        ],
      );
    }
  }

  void sendMessage(String message) {
    String script = "window.postMessage('$message', '*');";
    _controller.runJavaScript(script);
  }

  String sendUlr() {
    if (Platform.isIOS) {
      return 'https://drbalcony.com/api/redirector?platform=ios';
    } else if (Platform.isAndroid) {
      return 'https://drbalcony.com/api/redirector?platform=android';
    } else {
      return 'https://drbalcony.com/api/redirector';
    }
  }

  @override
  void initState() {
    super.initState();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..canGoBack()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            String? token = await storage.read(key: 'token');
            if (token != null) {
              bnb.value = true;
              return NavigationDecision.navigate;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
           Page resource error:
           code: ${error.errorCode}
           description: ${error.description}
           errorType: ${error.errorType}
           isForMainFrame: ${error.isForMainFrame}
                  ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(sendUlr()),
          method: LoadRequestMethod.get,
          headers: {
            'Authorization': widget.webpage.ApiAuth,
            //'Content-Type': 'application/x-www-form-urlencoded',
            'drbalconytoken': widget.webpage.token
          });
    controller.addJavaScriptChannel(
      'DrBalcony',
      onMessageReceived: (JavaScriptMessage message) async {
        final messegeData = jsonDecode(message.message);

        String jsonString = jsonEncode(messegeData);
        final Map<String, dynamic> decodedData = jsonDecode(jsonString);
        if (decodedData['type'] == "functionality" &&
            decodedData['value'] == "logout") {
          signoutHandel(widget.webpage.token, context);
        }
        if (decodedData['type'] == "token") {
          tokener.value = decodedData['value'];
        }
        if (decodedData['type'] == "functionality" &&
            decodedData['value'] == "successLogin") {
          await storage.write(key: 'token', value: tokener.value);

          String? apiAuth = await storage.read(key: 'apiAuth');

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      webpage: RouterBalcony(apiAuth!, tokener.value),
                    )),
            (route) => false,
          );
        }
        if (decodedData['type'] == "functionality" &&
            decodedData['value'] == "existUser") {
          ShowDialogBox(context, "Click ok to jump to login screen", () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          }, "user Already registerd", true);
        }
        if (decodedData['type'] == "functionality" &&
            decodedData['value'] == "JumpLogin") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        }
        if (decodedData['type'] == "functionality" &&
            decodedData['value'] == "tokenExpired") {
          signoutHandel(widget.webpage.token, context);
        }
        if (decodedData['type'] == "functionality" &&
            decodedData['value'] == "deleteAccount") {
          ShowDialogBox(context, "Are You sure about deleting your account?",
              () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => GetStart()),
              (route) => false,
            );
            sendMessage("ConfirmDeleteAccount");
          }, "Delete Account notice", true);
        }
      },
    );

    if (controller.platform is AndroidWebViewController) {
      (controller.platform as AndroidWebViewController).setOnShowFileSelector(
        (FileSelectorParams params) async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) => const FileCamPicker(),
          );

          if (result is PickedFile) {
            return ['file://${result.path}'];
          } else if (result is FilePickerResult) {
            return result.paths
                .where((e) => e != null)
                .map((e) => 'file://${e!}')
                .toList();
          } else {
            return ['file://${result}'];
          }
        },
      );
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          sendMessage("back");

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: FutureBuilder(
          future: internetCheker(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('An error occurred: ${snapshot.error}'),
              );
            } else {
              if (snapshot.data == true) {
                return WebViewWidget(controller: _controller);
              } else if (snapshot.data == false) {
                return const Nointernet();
              } else {
                return Container();
              }
            }
          },
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: bnb,
          builder: (BuildContext context, value, Widget? child) {
            if (bnb.value == true) {
              return ValueListenableBuilder(
                builder: (BuildContext context, value, Widget? child) {
                  if (Platform.isAndroid) {
                    return BottomNavigationBar(
                        currentIndex: selectedIndex.value,
                        onTap: onItemTapped,
                        type: BottomNavigationBarType.fixed,
                        items: barItems);
                  } else {
                    return ios.CupertinoTabBar(
                        currentIndex: selectedIndex.value,
                        inactiveColor: Colors.grey[500]!,
                        onTap: onItemTapped,
                        items: barItems);
                  }
                },
                valueListenable: selectedIndex,
              );
            } else {
              return Container(
                height: 0,
              );
            }
          },
        ),
      ),
    );
  }
}



//--------------------------------------------------Doc--------------------------------------------------\\
/*
This code is implementing a Flutter webview to display a web application inside the mobile app.

Some key things it is doing:

- Importing necessary packages like webview_flutter, file picker etc.

- Defining a WebView widget class that will hold the webview controller and handle interactions

- Creating a WebView controller and setting properties like js mode, navigation delegate etc

- Loading the initial URL with parameters like token

- Adding a JavaScript channel to handle messages from the web app

- Handling events like page load, errors etc using the navigation delegate

- Providing file picking functionality for Android

- Building the UI with the actual WebView widget, app bar, bottom nav bar

- Handling back button presses, showing a connectivity error

- Passing data between Flutter and web app using the JS channel

So in summary, it is implementing a full-fledged webview that can:

- Load and display a responsive web application
- Handle file/image uploads
- Pass data/messages between webview and Flutter code
- Integrate with native features like connectivity, auth etc

This allows building hybrid mobile apps by combining a web frontend with native Flutter functionality.
*/