import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:DrBalcony/getStart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

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

// Future<void> sendPostRequest(String username, String password) async {
//   final url = 'https://drbalcony.site/api/authenticator';
//   final headers = {
//     'Authorization': 'Basic ' + base64Encode(utf8.encode('$username:$password'))
//   };
//   final body = {'username': '$username', 'password': '$password'};

//   final response =
//       await http.post(Uri.parse(url), headers: headers, body: body);

//   if (response.statusCode == 200) {
//     // Request successful, handle the response
//     final data = jsonDecode(response.body);
//     print(data);
//   } else {
//     // Request failed, handle the error
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

Future<List<String>> sendAuthPostReq(
    String type, String username, String password, String? accessToken) async {
  final url = 'https://drbalcony.com/api/authenticator';
  await storage.write(key: 'apiAuth', value: apiKey);
  // String credentials = '$username:$password';
  // String encodedCredentials = base64.encode(utf8.encode(credentials));
  String? apiAuth = await storage.read(key: 'apiAuth');
  final headers = {
    'Authorization':
        //'Basic $encodedCredentials',

        apiKey,
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
    // Request successful, handle the response
    final bodyData = jsonDecode(response.body);

    //final bodyHeader = jsonDecode(response.headers);
    //var headers = response.headers;
    //var authtoken=headers['key1'];
    String jsonString = jsonEncode(bodyData);
    Map<String, dynamic> decodedData = jsonDecode(jsonString);
    if (decodedData['status'] == 1) {
      return ["done${decodedData['token']}", apiKey];
    }
    if (decodedData['status'] == 0) {
      return ["fail${decodedData['msg']}"];
    }
    if (decodedData['status'] == -1) {
      return ["noac${decodedData['msg']}"];
    }

    //   print(decodedData['status']); // prints "John"
    // print(decodedData['name']);
  }
  return [];

  // else {
  //   return "";
  //   // Request failed, handle the error
  //  // print('Request failed with status: ${response.statusCode}.');
  // }
}

Future<List<String>> forgetpass(String email) async {
  final url = 'https://drbalcony.com/api/forgetpass';
  //await storage.write(key: 'apiAuth', value: apiKey);
  // String credentials = '$username:$password';
  // String encodedCredentials = base64.encode(utf8.encode(credentials));
  String? apiAuth = await storage.read(key: 'apiAuth');
  final headers = {
    'Authorization':
        //'Basic $encodedCredentials',

        apiKey,
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
    //   print(decodedData['status']); // prints "John"
    // print(decodedData['name']);
  }
  // else {
  //   return "";
  //   // Request failed, handle the error
  //  // print('Request failed with status: ${response.statusCode}.');
  // }
  return [];
}

Future<bool> killToken(String token) async {
  final url = 'https://drbalcony.com/api/killToken';
  // String credentials = '$username:$password';
  // String encodedCredentials = base64.encode(utf8.encode(credentials));
  final headers = {
    'Authorization':
        //'Basic $encodedCredentials',

        apiKey,
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

void ShowDialogBox(BuildContext context, String res, VoidCallback onPressed,
    String title, bool cancel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return ios.CupertinoAlertDialog(
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
    return ios.CupertinoNavigationBar(
        // backgroundColor: Color(0xFFBBE4DC),
        // backgroundColor: Colors.transparent,
        // padding: EdgeInsetsDirectional.only(bottom: 2),
        // leading: ios.CupertinoButton(
        //   child: ios.Icon(color: Colors.grey[700], Icons.menu),
        //   onPressed: () {
        //     // sendMessage('OpenDrawer');
        //   },
        // ),
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

        // trailing: PopupMenuButton(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20)
        //           .copyWith(topRight: Radius.circular(0))),
        //   //padding: EdgeInsets.all(10),
        //   //  elevation: 10,
        //   color: Colors.grey.shade100,
        //   child: Container(
        //     //alignment: Alignment.center,
        //     // height: 45,
        //     // width: 45,
        //     margin: EdgeInsets.only(right: 10),
        //     decoration: BoxDecoration(
        //         boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black45)],
        //         color: Colors.white,
        //         shape: BoxShape.circle),
        //     child: Icon(
        //       Icons.more_horiz_rounded,
        //       //Icons.ios,
        //       color: Colors.grey,
        //     ),
        //   ),
        //   // onSelected: (value) {
        //   //   ScaffoldMessenger.of(context)
        //   //       .showSnackBar(SnackBar(content: Text('$value item pressed')));
        //   // },
        //   itemBuilder: (context) {
        //     return [
        //       // PopupMenuItem(
        //       //     onTap: () async {
        //       //       final signout = await killToken(widget.webpage.token);
        //       //       if (signout) {
        //       //         await storage.deleteAll();
        //       //         Navigator.of(context).push(MaterialPageRoute(
        //       //           builder: (context) {
        //       //             return LoginScreen();
        //       //           },
        //       //         ));
        //       //       }
        //       //     },
        //       //     value: 'Sign out',
        //       //     child: Column(
        //       //       crossAxisAlignment: CrossAxisAlignment.start,
        //       //       children: [
        //       //         Row(
        //       //           children: [
        //       //             Icon(
        //       //               Icons.logout,
        //       //               size: 20,
        //       //               color: Colors.black45,
        //       //             ),
        //       //             SizedBox(
        //       //               width: 5,
        //       //             ),
        //       //             Text(
        //       //               'Sign out',
        //       //               style: TextStyle(
        //       //                   color: Colors.black54,
        //       //                   fontSize: 13,
        //       //                   fontWeight: FontWeight.w500),
        //       //             ),
        //       //           ],
        //       //         ),
        //       //         Divider()
        //       //       ],
        //       //     )),
        //     ];
        //   },
        // ),
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
      // leading: IconButton(
      //     onPressed: () {
      //       //  sendMessage('OpenDrawer');
      //     },
      //     icon: const Icon(Icons.menu)),
      actions: [
        // PopupMenuButton(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20)
        //           .copyWith(topRight: Radius.circular(0))),
        //   //padding: EdgeInsets.all(10),
        //   //  elevation: 10,
        //   color: Colors.grey.shade100,
        //   child: Container(
        //     //alignment: Alignment.center,
        //     // height: 45,
        //     // width: 45,
        //     margin: EdgeInsets.only(right: 10),
        //     decoration: BoxDecoration(
        //         //  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black45)],
        //         color: const Color.fromARGB(0, 33, 149, 243),
        //         shape: BoxShape.circle),
        //     child: Icon(
        //       Icons.more_vert_rounded,
        //       //Icons.ios,
        //       color: const Color.fromARGB(255, 255, 255, 255),
        //     ),
        //   ),
        //   // onSelected: (value) {
        //   //   ScaffoldMessenger.of(context)
        //   //       .showSnackBar(SnackBar(content: Text('$value item pressed')));
        //   // },
        //   itemBuilder: (context) {
        //     return [
        //       PopupMenuItem(
        //           onTap: () async {
        //             // final signout = await killToken(widget.webpage.token);
        //             // if (signout) {
        //             //   await storage.deleteAll();
        //             //   Navigator.of(context).push(MaterialPageRoute(
        //             //     builder: (context) {
        //             //       return LoginScreen();
        //             //     },
        //             //   ));
        //             // }
        //           },
        //           value: 'Sign out',
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 children: [
        //                   Icon(
        //                     Icons.logout,
        //                     size: 20,
        //                     color: Colors.black45,
        //                   ),
        //                   SizedBox(
        //                     width: 5,
        //                   ),
        //                   Text(
        //                     'Sign out',
        //                     style: TextStyle(
        //                         color: Colors.black54,
        //                         fontSize: 13,
        //                         fontWeight: FontWeight.w500),
        //                   ),
        //                 ],
        //               ),
        //               Divider()
        //             ],
        //           )),
        //     ];
        //   },
        // ),
        // IconButton(
        //     onPressed: () {
        //       sendMessage('OpenProfile');
        //     },
        //     icon: const Icon(Icons.manage_accounts)),
      ],
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

// //signin google
// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: [
//     'email',
//     //'https://drbalcony.site/customer/login/googleOAuthResponse',
//   ],
// );
// final FirebaseAuth _auth = FirebaseAuth.instance;
// //signin google
// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the Google Authentication flow.

//   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//   // Obtain the authentication tokens from the GoogleSignInAccount.
//   final GoogleSignInAuthentication googleAuth =
//       await googleUser!.authentication;
//   // Create a new credential for Firebase Authentication.
//   final OAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   // Sign in to Firebase using the Google credentials.
//   return await _auth.signInWithCredential(credential);
// }

//signin google
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
