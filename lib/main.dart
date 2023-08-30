import 'package:DrBalcony/screens/get_start/getStart.dart';
import 'package:DrBalcony/widgets/colors.dart';
import 'package:DrBalcony/screens/web_view/webview.dart';
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login/Auth/firebase_options.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'DrBalcony',
      initialRoute: '/',
      routes: {
        '/': (context) => initialRoute,
      },
    );
  }
}

//--------------------------------------------------Doc--------------------------------------------------\\
/*
The provided code is a Flutter application that initializes Firebase, sets system UI overlay style, and defines the main entry point of the application. Here's a breakdown of what the code does:

1. The code imports various Dart packages and local files required for the implementation, including `package:DrBalcony/getStart.dart`, `package:DrBalcony/styles/colors.dart`, `package:DrBalcony/webview.dart`, `package:DrBalcony/webviewUtils.dart`, `package:flutter/material.dart`, `package:flutter/services.dart`, `package:flutter_secure_storage/flutter_secure_storage.dart`, and `package:firebase_core/firebase_core.dart`.

1. The `main` function is the entry point of the application.

   - `SystemChrome.setSystemUIOverlayStyle`: It sets the system UI overlay style, specifically the color of the system navigation bar and the brightness of the navigation bar icons.

   - `WidgetsFlutterBinding.ensureInitialized()`: It initializes the Flutter bindings.

   - `Firebase.initializeApp`: It initializes Firebase using the default Firebase options provided in `firebase_options.dart`.

   - An instance of `FlutterSecureStorage` is created to allow secure storage access.

   - An API key is assigned to the `apiKey` variable.

   - The API key is stored securely using `storage.write`.

   - The stored API key and token are retrieved from secure storage using `storage.read`.

   - Based on the presence of the API key and token, an `initialRoute` widget is assigned either a `WebView` widget with `RouterBalcony(apiAuth, token)` or a `GetStart` widget.

   - The `MyApp` widget is instantiated and the `initialRoute` is passed as a parameter.

   - The `runApp` function is called with the `MyApp` widget as the root widget of the application.

1. The `MyApp` class is defined, which is a `StatelessWidget` representing the root application widget.

   - The class has a required parameter `initialRoute` of type `Widget`.

   - The `build` method is overridden to build and return the widget tree for the application.

   - The `MaterialApp` widget is used as the root widget, providing the basic structure for the application.

     - The `themeMode` property is set to `ThemeMode.system`, which allows the theme to adapt based on the system's preferred theme (light or dark).

     - The `darkTheme` property is set to a predefined dark theme.

     - The `theme` property is set to a predefined light theme.

     - `debugShowCheckedModeBanner` is set to `false` to hide the debug banner in the top-right corner of the screen.

     - The `title` property is set to 'DrBalcony'.

     - The `initialRoute` property is set to '/'.

     - The `routes` property defines a map of named routes and their corresponding widget builders. In this case, only the root route `'/'` is defined, and it points to the `initialRoute` widget defined earlier.

The code initializes Firebase, sets system UI styles, and defines the main entry point of the application with appropriate routes and themes.
*/