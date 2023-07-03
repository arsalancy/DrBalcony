// import 'package:dr_balcony/Auth/pages/welcome.dart';
import 'package:DrBalcony/Auth/login_screen.dart';
import 'package:DrBalcony/getStart.dart';
import 'package:DrBalcony/styles/colors.dart';
import 'package:DrBalcony/webview.dart';
import 'package:DrBalcony/webviewUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 0, 40, 56),
      systemNavigationBarIconBrightness: Brightness.light));
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final storage = FlutterSecureStorage();
  final apiKey =
      'Basic ZkdoN0Q0VHlIbDA5ckd0NDc6Rm52NzVUUmhlNDVIaWQ5WXU2VDZ3UjQxTjBkVng0R3BTZjkyRnQ1RWZzVjRUMFNnaFY0';
  await storage.write(key: 'apiAuth', value: apiKey);
  // Step 3
  // SystemChrome.setPreferredOrientations(
  //   [
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((value) =>

  // runApp(const MyApp()));

  String? apiAuth = await storage.read(key: 'apiAuth');
  String? token = await storage.read(key: 'token');
  Widget initialRoute = (apiAuth != null && token != null)
      ? WebView(
          webpage: RouterBalcony(apiAuth, token),
        )
      : GetStart();

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: darkTheme,
      theme: lightTheme,
      // theme: ThemeData(
      //   textSelectionTheme: TextSelectionThemeData(
      //     cursorColor: Colors.blue,
      //     selectionColor: Colors.blue.shade400,
      //     selectionHandleColor: Colors.blue,
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      title: 'DrBalcony',
      initialRoute: '/',
      routes: {
        '/': (context) => initialRoute,
        //'/login': (context) => LoginScreen(),
        //'/webview': (context) => we,
      },
    );
  }
}
