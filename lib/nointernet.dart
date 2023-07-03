import 'package:DrBalcony/getStart.dart';
import 'package:DrBalcony/webview.dart';
import 'package:DrBalcony/webviewUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Auth/login_screen.dart';

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
                // style: const ButtonStyle(
                //   backgroundColor: MaterialStatePropertyAll<Color>(
                //       Color.fromARGB(255, 255, 208, 0)),
                // ),
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




// import 'dart:async';

// import 'package:dr_balcony/getStart.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class Nointernet extends StatefulWidget {
// // late  WebViewController controller;
  
//     final WebViewController controller;
//  const Nointernet({Key? key, required this.controller}) : super(key: key);

//   @override
//   State<Nointernet> createState() => _NointernetState();
// }

// class _NointernetState extends State<Nointernet> {
//    late Timer _timer;
//   @override
  
//   void initState() {
//     // TODO: implement initState
   
//      _timer = Timer(Duration(seconds: 5), () {
//       _widgetNotifier.value = _nextWidget;
//     });
//     super.initState();
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose _timer.cancel();
//      _timer.cancel();
//     super.dispose();
//   }
//    Widget _currentWidget = Webviewer(controller: widget.controller,);
//   Widget _nextWidget = widgetNointernet();
//   ValueNotifier<Widget> _widgetNotifier = ValueNotifier<Widget>(WidgetA());
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       alignment: Alignment.center,
//       color:const Color.fromARGB(255, 233, 237, 241),
//       child: widgetNointernet(),
//     );
//   }
// }

// class widgetNointernet extends StatelessWidget {
//   const widgetNointernet({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
//   Image.asset("assets/nowifi.png"),
//   const Padding(
//     padding: EdgeInsets.all(10.0),
//     child: Text(
//       textAlign: TextAlign.center,
//                             "There Is No Internet Connection",
//                             style: TextStyle(
                             
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 20,
//                                 color: Color.fromARGB(255, 41, 0, 0)),
//                           ),
//   ),
//   const Padding(
//     padding: EdgeInsets.all(10.0),
//     child: Text(
//     textAlign: TextAlign.center,
//                           "Please Check Your Internet Connection And Try Again.",
//                           style: TextStyle(
                           
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                               color: Color.fromARGB(255, 41, 0, 0)),
//                         ),
//   ),
  
//                       SizedBox(
//                   width: 120,
//                   child: ElevatedButton(
//                     // style: const ButtonStyle(
//                     //   backgroundColor: MaterialStatePropertyAll<Color>(
//                     //       Color.fromARGB(255, 255, 208, 0)),
//                     // ),
//                     onPressed: () {
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GetStart()));
//                     },
//                     child: const Text(
//                       "Back",
//                       style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//                     ),
//                   ),
//                 ),
// ],
//     );
//   }
// }
// class Webviewer extends StatefulWidget {
//  final WebViewController controller;
//  const Webviewer({Key? key, required this.controller}) : super(key: key);

//   @override
//   State<Webviewer> createState() => _WebviewerState();
// }

// class _WebviewerState extends State<Webviewer> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }