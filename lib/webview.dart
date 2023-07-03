import 'dart:convert';

import 'package:DrBalcony/FileCampicker.dart';
import 'package:DrBalcony/Auth/login_screen.dart';
import 'package:DrBalcony/nointernet.dart';
import 'package:DrBalcony/webviewUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:uuid/uuid.dart';
import 'dart:io' show Platform;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
//import 'dart:async';
import 'package:flutter/cupertino.dart' as ios;
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';

class WebView extends StatefulWidget {
  final RouterBalcony webpage;
  const WebView({Key? key, required this.webpage}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

// Future<bool> _exitApp(BuildContext context) async {
//   late final PlatformWebViewControllerCreationParams params;

//   if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//     params = WebKitWebViewControllerCreationParams(
//       allowsInlineMediaPlayback: true,
//       mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//     );
//   } else {
//     params = const PlatformWebViewControllerCreationParams();
//   }
//   WebViewController controllerGlobal =
//       WebViewController.fromPlatformCreationParams(params);

//   if (await controllerGlobal.canGoBack()) {
//     // print("onwill goback");
//     controllerGlobal.goBack();
//     return Future.value(false);
//   } else {
//     return Future.value(false);
//   }
// }

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
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.dashboard_rounded),
    //   label: 'Dashboard',
    // ),
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
    //await _controller.loadRequest(Uri.parse(sendUlr()));

    //final url = await _controller.currentUrl();
    //print("url is : $url");
  }

  PreferredSizeWidget getAppbar() {
    if (Platform.isAndroid) {
      return ios.CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(bottom: 2),
        leading: ios.CupertinoButton(
          child: ios.Icon(color: Colors.grey[700], Icons.menu),
          onPressed: () {
            // sendMessage('OpenDrawer');
          },
        ),
        //  IconButton(
        //     splashColor: Colors.blue,
        //     highlightColor: Colors.blue,
        //     onPressed: () {
        //       sendMessage('OpenDrawer');
        //     },
        //     icon: ios.Icon(color: Colors.grey[700], Icons.menu))
        //,
        // trailing: ios.CupertinoButton(
        //     onPressed: () {
        //       sendMessage('OpenProfile');
        //     },
        //     child: ios.Icon(color: Colors.grey[700], Icons.manage_accounts)),

        trailing: PopupMenuButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
                  .copyWith(topRight: Radius.circular(0))),
          //padding: EdgeInsets.all(10),
          //  elevation: 10,
          color: Colors.grey.shade100,
          child: Container(
            //alignment: Alignment.center,
            // height: 45,
            // width: 45,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black45)],
                color: Colors.white,
                shape: BoxShape.circle),
            child: Icon(
              Icons.more_horiz_rounded,
              //Icons.ios,
              color: Colors.grey,
            ),
          ),
          // onSelected: (value) {
          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(SnackBar(content: Text('$value item pressed')));
          // },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  onTap: () async {
                    signoutHandel(widget.webpage.token, context);

                    // final signout = await killToken(widget.webpage.token);
                    // if (signout) {
                    //   await storage.deleteAll();
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) {
                    //       return LoginScreen();
                    //     },
                    //   ));
                    // }
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
        //  IconButton(
        //     splashColor: Colors.blue,
        //     highlightColor: Colors.blue,
        //     onPressed: () {
        //       sendMessage('OpenProfile');
        //     },
        //     icon: ios.Icon(color: Colors.grey[700], Icons.manage_accounts)),
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
            //padding: EdgeInsets.all(10),
            //  elevation: 10,
            color: Colors.grey.shade100,
            child: Container(
              //alignment: Alignment.center,
              // height: 45,
              // width: 45,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  //  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black45)],
                  color: const Color.fromARGB(0, 33, 149, 243),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.more_vert_rounded,
                //Icons.ios,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            // onSelected: (value) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text('$value item pressed')));
            // },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () async {
                      signoutHandel(widget.webpage.token, context);
                      // final signout = await killToken(widget.webpage.token);
                      // if (signout) {
                      //   await storage.deleteAll();
                      //   Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginScreen()),
                      //     (route) => false,
                      //   );
                      // }
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
          // IconButton(
          //     onPressed: () {
          //       sendMessage('OpenProfile');
          //     },
          //     icon: const Icon(Icons.manage_accounts)),
        ],
      );
    }
  }

  void sendMessage(String message) {
    String script = "window.postMessage('$message', '*');";
    _controller.runJavaScript(script);
  }

  String sendUlr() {
    // if (firstTimeLoad.value) {
    //firstTimeLoad.value = false;

    return 'https://drbalcony.com/api/redirector';
    // }
    // switch (selectedIndex.value) {
    //   case 0:
    //     {
    //       selectedout.value = false;
    //       return 'https://eeeadvisorproject.com/user?mobile=1&v=${randgen()}#page=dashboard';
    //     }

    //   case 1:
    //     {
    //       selectedout.value = false;
    //       return 'https://eeeadvisorproject.com/user?mobile=1&v=${randgen()}#page=project';
    //     }

    //   case 2:
    //     {
    //       selectedout.value = false;

    //       return 'https://eeeadvisorproject.com/user?mobile=1&v=${randgen()}#page=profile';
    //     }

    //   default:
    //     selectedout.value = false;
    //     return 'https://drbalcony.site/api/redirector';
    // }
  }

  @override
  void initState() {
    //randgen();

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

            //  else if (request.url.contains("logout")) {
            //   signoutHandel(widget.webpage.token, context);
            //   return NavigationDecision.prevent;
            // }

            return NavigationDecision.navigate;

            // if (!request.url.contains('#page=project') &&
            //     !request.url.contains('#page=dashboard') &&
            //     !request.url.contains('#page=profile')) {
            //   bnb.value = true;
            //   if (counterSelectedout.value >= 1) {
            //     selectedout.value = true;
            //   }
            //   counterSelectedout.value += 1;
            //   return NavigationDecision.navigate;
            // } else if (request.url.contains('#page=project') &&
            //     request.url.contains('#page=dashboard') &&
            //     request.url.contains('#page=profile')) {
            //   bnb.value = true;
            //   selectedout.value = false;
            //   return NavigationDecision.navigate;
            // }
            // if (request.url.contains('user')) {
            //   currentUrL.value = (await controller.currentUrl())!;

            //   bnb.value = true;

            //   return NavigationDecision.navigate;
            // } else {
            //   bnb.value = false;
            //   return NavigationDecision.navigate;
            // }
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
          // String? token = await storage.read(key: 'token');
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
            decodedData['value'] == "tokenExpired") {
          signoutHandel(widget.webpage.token, context);
        }
      },
    );

    if (controller.platform is AndroidWebViewController) {
      (controller.platform as AndroidWebViewController).setOnShowFileSelector(
        (FileSelectorParams params) async {
          // Show options for selecting image from gallery or capturing a new image using camera
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) => const FileCamPicker(),
          );

          // Return selected file(s) to the web page
          if (result is PickedFile) {
            return ['file://${result.path}'];
          } else if (result is FilePickerResult) {
            return result.paths
                .where((e) => e != null)
                .map((e) => 'file://${e!}')
                .toList();
          } else {
            return [];
          }
        },
      );
    }

    _controller = controller;
  }
  // var barheight = MediaQuery.of(context).viewPadding.top;
  // var height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          sendMessage("back");
          //_controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     showModalBottomSheet<void>(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return Container(
        //           height: 500,
        //           color: const Color.fromARGB(255, 248, 248, 246),
        //           child: Center(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               mainAxisSize: MainAxisSize.min,
        //               children: <Widget>[
        //                 const Expanded(
        //                   child: TextField(
        //                     maxLines: null,
        //                     expands: true,
        //                   ),
        //                 )
        //                 // const Text('Modal BottomSheet'),
        //                 ,
        //                 ElevatedButton(
        //                   child: const Text('send'),
        //                   onPressed: () => Navigator.pop(context),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
        // appBar: PreferredSize(
        //     preferredSize: const Size.fromHeight(50),
        //     child: ValueListenableBuilder(
        //       valueListenable: bnb,
        //       builder: (BuildContext context, dynamic value, Widget? child) {
        //         return getAppbar();
        //       },
        //     ))

        // // //  AppBar(actions: []),
        // // ,
        // ,
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

        //  bottomNavigationBar:ios.CupertinoTabBar(items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(ios.CupertinoIcons.star_fill),
        //       label: 'Favorites',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(ios.CupertinoIcons.clock_solid),
        //       label: 'Recents',
        //     ),],)

        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: bnb,
          builder: (BuildContext context, value, Widget? child) {
            if (bnb.value == true) {
              return ValueListenableBuilder(
                builder: (BuildContext context, value, Widget? child) {
                  if (Platform.isAndroid) {
                    return BottomNavigationBar(
                        currentIndex: selectedIndex.value,
                        // unselectedFontSize: selectedout.value ? 15 : 14,
                        // selectedFontSize: selectedout.value ? 14 : 15,
                        // selectedItemColor: selectedout.value
                        //     ? Colors.grey[500]
                        //     : Colors.blue,
                        // unselectedItemColor: Colors.grey[500],
                        onTap: onItemTapped,
                        type: BottomNavigationBarType.fixed,
                        items: barItems);
                  } else {
                    return ios.CupertinoTabBar(
                        currentIndex: selectedIndex.value,

                        //   unselectedFontSize: selectedout.value ? 15 : 14,
                        // selectedFontSize: selectedout.value ? 14 : 15,
                        // activeColor: selectedout.value
                        //     ? Colors.grey[500]
                        //     : Colors.blue,
                        inactiveColor: Colors.grey[500]!,
                        onTap: onItemTapped,
                        // type: BottomNavigationBarType.fixed,
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

          //  child:
        ),
      ),
    );
  }
}
