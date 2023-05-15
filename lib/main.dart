import 'package:dr_balcony/getStart.dart';
import 'package:dr_balcony/webview.dart';
import 'package:flutter/material.dart';
import 'package:dr_balcony/login.dart';
import 'package:flutter/services.dart';
void main(
) {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      theme: ThemeData(
     textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.blue,
        selectionColor: Colors.blue.shade400,
        selectionHandleColor: Colors.blue,
     ),
   ),
      debugShowCheckedModeBanner: false,
      title: 'DrBalcony', home: const GetStart(
      
    ));
  }
}
