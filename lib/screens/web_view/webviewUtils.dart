import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:DrBalcony/provider/upload_provider.dart';
import 'package:DrBalcony/repository/sqlite.dart';
import 'package:DrBalcony/screens/get_start/getStart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

final storage = FlutterSecureStorage();
final apiKey =
    'Basic ZkdoN0Q0VHlIbDA5ckd0NDc6Rm52NzVUUmhlNDVIaWQ5WXU2VDZ3UjQxTjBkVng0R3BTZjkyRnQ1RWZzVjRUMFNnaFY0';

class RouterBalcony {
  String ApiAuth;
  String token;
  RouterBalcony(this.ApiAuth, this.token);
}

Future<bool> internetCheker() async {
  bool result = await InternetConnectionChecker().hasConnection;

  if (result == true) {
    return true;
  } else {
    return false;
  }
}

String randgen() {
  late String rand;
  rand = const Uuid().v4().substring(0, 8);
  return rand;
}

Future<List<String>> sendAuthPostReq(
    String type, String username, String password, String? accessToken) async {
  final url = 'https://drbalcony.com/api/authenticator';
  await storage.write(key: 'apiAuth', value: apiKey);

  //String? apiAuth = await storage.read(key: 'apiAuth');
  final headers = {
    'Authorization': apiKey,
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  late String body;
  switch (type) {
    case "regular":
      body = 'username=$username&password=$password';
      break;
    case "google":
      body = 'accessToken=$accessToken';
      break;
    case "apple":
      body = 'accessToken=$accessToken';
      break;
    default:
  }

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    final bodyData = jsonDecode(response.body);

    String jsonString = jsonEncode(bodyData);
    Map<String, dynamic> decodedData = jsonDecode(jsonString);

    if (decodedData['status'] == 1) {
      return ["done${decodedData['token']}", apiKey];
    }
    if (decodedData['status'] == 0) {
      return ["fail${decodedData['msg']}"];
    }
    if (decodedData['status'] == -1) {
      await signOutGoogle();
      return ["noac${decodedData['msg']}"];
    }
  }
  return [];
}

Future<List<String>> forgetpass(String email) async {
  final url = 'https://drbalcony.com/api/forgetpass';

  // String? apiAuth = await storage.read(key: 'apiAuth');
  final headers = {
    'Authorization': apiKey,
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  final body = 'email=$email';

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    final bodyData = jsonDecode(response.body);
    print(bodyData);
    String jsonString = jsonEncode(bodyData);
    Map<String, dynamic> decodedData = jsonDecode(jsonString);
    if (decodedData['status'] == 1) {
      return ["done${decodedData['msg']}"];
    } else if (decodedData['status'] == 0) {
      return ["fail${decodedData['msg']}"];
    }
  }

  return [];
}

Future<bool> killToken(String token) async {
  final url = 'https://drbalcony.com/api/killToken';

  final headers = {
    'Authorization': apiKey,
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  final body = 'token=$token';

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

// Future<bool> UploadDocs(String submitId, String filePath, int count) async {
//   final url = 'https://drbalcony.com/api/uploadDocument';

//   String? token = await storage.read(key: 'token');
//   late String base64Image;
//   String fileExtension = path.extension(filePath);
//   File file = File(filePath);
//   if (file.existsSync()) {
//     List<int> bytes = await file.readAsBytes();
//     base64Image = base64Encode(bytes);
//   } else {
//     base64Image = '';
//   }

//   final headers = {
//     'Authorization': apiKey,
//     'token': token as String,
//     'Content-Type': 'application/x-www-form-urlencoded',
//   };
//   final body = {
//     'submitId': submitId,
//     'File': base64Image,
//     'ext': fileExtension,
//     'count': count.toString()
//   };

//   final response =
//       await http.post(Uri.parse(url), headers: headers, body: body);

//   if (response.statusCode == 200) {
//     return true;
//   } else if (response.statusCode == 404) {
//     DBHelper dbhelper = DBHelper();
//     await dbhelper.deleteProject(int.parse(submitId));
//   }
//   print(response.reasonPhrase);
//   return false;
// }

// Future<bool> uploadDocs(String submitId, String filePath, int count) async {
//   final url = 'https://drbalcony.com/api/uploadDocument';

//   String? token = await storage.read(key: 'token');
//   String fileExtension = path.extension(filePath);
//   File file = File(filePath);

//   if (!file.existsSync()) {
//     print('File does not exist');
//     return false;
//   }

//   final headers = {
//     'Authorization': apiKey,
//     'token': token as String,
//   };

//   final request = http.MultipartRequest('POST', Uri.parse(url));
//   request.headers.addAll(headers);
//   request.fields['submitId'] = submitId;
//   request.fields['ext'] = fileExtension;
//   request.fields['count'] = count.toString();
//   request.files.add(await http.MultipartFile.fromPath('File', filePath));

//   final response = await request.send();

//   if (response.statusCode == 200) {
//     return true;
//   } else if (response.statusCode == 404) {
//     DBHelper dbhelper = DBHelper();
//     await dbhelper.deleteProject(int.parse(submitId));
//   }

//   print(response.reasonPhrase);
//   return false;
// }

void ShowDialogBox(BuildContext context, String res, VoidCallback onPressed,
    String title, bool cancel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return ios.CupertinoAlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            '$res.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          actions: cancel == true
              ? <Widget>[
                  ios.CupertinoButton(child: Text('OK'), onPressed: onPressed),
                  ios.CupertinoButton(
                      child: Text('cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ]
              : <Widget>[
                  ios.CupertinoButton(child: Text('OK'), onPressed: onPressed),
                ],
        );
      } else {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade300
              : Colors.white,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Text(
            '$res.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: cancel == true
              ? <Widget>[
                  TextButton(child: Text('OK'), onPressed: onPressed),
                  TextButton(
                      child: Text('cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ]
              : <Widget>[
                  TextButton(child: Text('OK'), onPressed: onPressed),
                ],
        );
      }
    },
  );
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter your email address';
  }
  final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return "done";
}

PreferredSizeWidget loginAppbar() {
  if (Platform.isIOS) {
    return ios.CupertinoNavigationBar();
  } else {
    return AppBar(
      actions: [],
    );
  }
}

void signoutHandel(String token, BuildContext context) async {
  final signout = await killToken(token);
  if (signout) {
    final storage = FlutterSecureStorage();
    final allKeys = await storage.readAll();

    for (final key in allKeys.keys) {
      if (key != "apiAuth") {
        await storage.delete(key: key);
      }
    }
    await storage.deleteAll();
    // final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    // await storage.deleteAll();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => GetStart()),
      (route) => false,
    );
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    //'https://drbalcony.site/customer/login/googleOAuthResponse',
  ],
);

//signin google
Future<String?> signInWithGoogle() async {
  // Trigger the Google Authentication flow.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  // Obtain the authentication tokens from the GoogleSignInAccount.
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  // Create a new credential for Firebase Authentication.
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in to Firebase using the Google credentials.

  await _auth.signInWithCredential(credential);
  return credential.accessToken;
}

Future<void> signOutGoogle() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignInAccount? googleUser =
  await _auth.signOut();
  await _googleSignIn.signOut();
  //googleUser.
}

void testFetchResiduals() async {
  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    final residualsDir = Directory('${appDocDir.path}/residuals');

    if (await residualsDir.exists()) {
      print('Fetching residuals from: ${residualsDir.path}');

      final List<FileSystemEntity> residuals =
          residualsDir.listSync(recursive: true);

      for (final entity in residuals) {
        if (entity is File) {
          print('File: ${entity.path}');
        } else if (entity is Directory) {
          print('Folder: ${entity.path}');
        }
      }
    } else {
      print('Residuals folder does not exist');
    }
  } catch (e) {
    print('Error fetching residuals: $e');
  }
}

// Future<void> residualDocsSender() async {
//   String? token = await storage.read(key: 'token');
//   try {
//     final appDocDir = await getApplicationDocumentsDirectory();
//     final residualsDir = Directory('${appDocDir.path}/residuals');

//     if (await residualsDir.exists()) {
//       final List<Directory> folders =
//           residualsDir.listSync().whereType<Directory>().toList();

//       for (final folder in folders) {
//         print('Folder path: ${folder.path}');
//         final submitId = folder.path.split('/').last;
//         final files = folder.listSync().whereType<File>().toList();
//         final List<String> folderFilePaths =
//             files.map((file) => file.path).toList();
//         DBHelper dbHelper = DBHelper();
//         bool isAllSent = true; // Initialize to true

//         for (var i = 0; i < folderFilePaths.length; i++) {
//           final isSent = await uploadDocs(
//               submitId, folderFilePaths[i], folderFilePaths.length);
//           if (!isSent) {
//             isAllSent = false; // Mark as false if any file is not sent
//           }
//         }

//         if (isAllSent) {
//           dbHelper.deleteProject(int.parse(submitId));
//           deleteInvalidDirectories();
//         }
//       }
//     }
//   } catch (e) {
//     print('Error sending residuals: $e');
//   }
// }
// Future<void> residualDocsSender() async {
//   String? token = await storage.read(key: 'token');
//   try {
//     final appDocDir = await getApplicationDocumentsDirectory();
//     final residualsDir = Directory('${appDocDir.path}/residuals');

//     if (await residualsDir.exists()) {
//       final List<Directory> folders =
//           residualsDir.listSync().whereType<Directory>().toList();

//       for (final folder in folders) {
//         print('Folder path: ${folder.path}');
//         final submitId = folder.path.split('/').last;
//         final files = folder.listSync().whereType<File>().toList();
//         // try {
//         //  // files = folder.listSync().whereType<File>().toList();

//         // } catch (e) {
//         //   print(e);
//         // }
//         final List<String> folderFilePaths =
//             files!.map((file) => file.path).toList();
//         DBHelper dbHelper = DBHelper();
//         bool isAllSent = false;
//         // for (var folderfile in folderFilePaths) {
//         //   await UploadDocs(token, submitId, folderfile);
//         // }
//         for (var i = 0; i < folderFilePaths.length; i++) {
//           final isSent = await UploadDocs(submitId, folderFilePaths[i]);
//           if (isSent == true) {
//             continue;
//           }
//           if (i == folderFilePaths.length) {
//             isAllSent = true;
//           }
//           if (isAllSent) {
//             dbHelper.deleteProject(int.parse(submitId!));
//             deleteInvalidDirectories();
//           }
//         }
//       }
//     }
//   } catch (e) {
//     print('Error sending residuals: $e');
//   }
// }

Future<void> deleteInvalidDirectories() async {
  // Retrieve project IDs from the database
  DBHelper dbhelper = DBHelper();
  List<Map<String, dynamic>> projects = await dbhelper.getAllProjects();

  // Get the residuals directory
  final appDocDir = await getApplicationDocumentsDirectory();
  final residualsDir = Directory('${appDocDir.path}/residuals');

  // Get the list of directories inside the residuals directory
  if (residualsDir.existsSync()) {
    List<Directory> directories =
        residualsDir.listSync().whereType<Directory>().toList();

    // Iterate over the directories and delete the invalid ones
    for (Directory directory in directories) {
      String directoryName = path.basename(directory.path);
      int? directoryId = int.tryParse(directoryName);

      // Check if the directory name is a valid ID and if it exists in the projects list
      if (directoryId != null &&
          !projects.any((project) => project['id'] == directoryId)) {
        await directory.delete(recursive: true);
        print('Deleted directory: $directoryName');
      }
    }
  }
}

Future<void> deleteSpecificDirectory(String submitId) async {
  // Retrieve project IDs from the database
  // DBHelper dbhelper = DBHelper();
  // List<Map<String, dynamic>> projects = await dbhelper.getAllProjects();

  // Get the residuals directory
  final appDocDir = await getApplicationDocumentsDirectory();
  final residualsDir = Directory('${appDocDir.path}/residuals');

  // Get the list of directories inside the residuals directory
  if (residualsDir.existsSync()) {
    List<Directory> directories =
        residualsDir.listSync().whereType<Directory>().toList();

    // Iterate over the directories and delete the invalid ones
    for (Directory directory in directories) {
      String directoryName = path.basename(directory.path);
      // int? directoryId = int.tryParse(directoryName);

      // Check if the directory name is a valid ID and if it exists in the projects list
      // if (directoryId != null &&
      //     !projects.any((project) => project['id'] == directoryId)) {
      if (directoryName == submitId) {
        await directory.delete(recursive: true);
      }
      print('Deleted directory: $directoryName');
    }
  }
  //}
}

//--------------------------------------------------Doc--------------------------------------------------\\
/*
The provided code is a Dart code snippet that includes various imports and function definitions. Here's a breakdown of what the code does:

1. Imports: The code imports various Dart packages and libraries that are required for the functionality implemented in the code. These packages include `dart:async`, `dart:convert`, `dart:io`, `package:DrBalcony/getStart.dart`, `package:firebase_auth/firebase_auth.dart`, `package:flutter/cupertino.dart` (aliased as `ios`), `package:flutter/material.dart`, `package:flutter_secure_storage/flutter_secure_storage.dart`, `package:google_sign_in/google_sign_in.dart`, `package:internet_connection_checker/internet_connection_checker.dart`, `package:uuid/uuid.dart`, and `package:http/http.dart`.

1. Variable Declarations:

   - `storage`: An instance of `FlutterSecureStorage` used for secure storage.
   - `apiKey`: A string containing an API key.

1. Class Definition:

   - `RouterBalcony`: A class with `ApiAuth` and `token` properties used for routing purposes.

1. Function Definitions:

   - `internetCheker()`: An asynchronous function that checks for internet connectivity using the `InternetConnectionChecker` package. It returns a boolean value indicating whether there is an internet connection.
   - `randgen()`: A function that generates a random string using the `Uuid` package. It returns the generated string.
   - `sendAuthPostReq()`: An asynchronous function that sends an authentication POST request to a specified URL. It takes parameters such as the request type, username, password, and access token. It returns a list of strings based on the response received.
   - `forgetpass()`: An asynchronous function that sends a POST request to a specified URL for password recovery. It takes an email parameter and returns a list of strings based on the response received.
   - `killToken()`: An asynchronous function that sends a POST request to a specified URL to invalidate a token. It takes a token parameter and returns a boolean value indicating whether the request was successful.
   - `ShowDialogBox()`: A function that displays a dialog box with a given context, response string, callback function, title, and cancel flag.
   - `validateEmail()`: A function that validates an email address based on a regular expression. It takes an email value as input and returns a string indicating the validation result.
   - `loginAppbar()`: A function that returns an app bar widget based on the platform (iOS or other).
   - `signoutHandel()`: A function that handles the sign-out process. It invalidates the token, clears stored data, signs out from Google, and navigates to the "GetStart" screen.
   - `signInWithGoogle()`: An asynchronous function that performs Google sign-in using Firebase Authentication. It returns the access token obtained from the authentication process.
   - `signOutGoogle()`: An asynchronous function that signs out the user from Google and Firebase Authentication.

The code seems to be related to authentication and user management, including features such as internet connectivity checks, API requests for authentication, password recovery, token management, and Google sign-in/sign-out functionality.
*/




//I have a floater application and I want to implement a provider that holds a Queue and this Queue is always ready for service meaning if I add something to this Queue list it's going to do this task for each item in the Queue . this method is my task and it looks inside residual and send everything inside it.