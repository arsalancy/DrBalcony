// import 'dart:convert';
// import 'mainpage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Login extends StatelessWidget {
//   const Login({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const faild = SnackBar(
//       content: Text('Not valid'),
//     );
//     var sw = MediaQuery.of(context).size.width;
//     // final ApiClient _apiClient = ApiClient();
//     final email = TextEditingController();
//     final password = TextEditingController();
//     return Scaffold(
//         appBar: AppBar(
//         toolbarHeight: 0.2,
//         ),
//         body: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//         Container(
//             height: sw / 5,
//             color: const Color(0xff00a3ff),
//             child: Center(child:Container(
           
//               decoration: BoxDecoration(
//                    color:Colors.grey[200],
//                 borderRadius: BorderRadius.circular(2)
//               ),
              
//               child: Image.asset("assets/logo.png")))),
//         const Padding(
//            padding:  EdgeInsets.all(10.0),
//            child:  Text("Sign In to EEEadvisor",
//            style: TextStyle(fontSize: 20)),
//          ),
//          Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('New Here?'),
//              TextButton(onPressed:() {
               
//              }, child:const Text("create an account"))
//           ],
//          ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: TextFormField(
//             decoration: InputDecoration(
//             fillColor: Colors.grey,  
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                   width: 2.0,
                  
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                   width: 2.0,
                  
//                 ),
//               ),
//             ),
//             controller: email,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: TextFormField(
//             decoration: InputDecoration(
//               fillColor: Colors.grey,  
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: const BorderSide(
//                     color: Colors.grey,
//                     width: 2.0,
                    
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: const BorderSide(
//                     color: Colors.grey,
//                     width: 2.0,
                    
//                   ),
//                 ),
//               ),
//             controller: password,
//           ),
//         ),
//         OutlinedButton(
//           style: ButtonStyle(
          
//           ),
//             onPressed: () async {
//               var response = await login(email.text, password.text);
        
//               if (response=="error") {
//                  ScaffoldMessenger.of(context).showSnackBar(faild);
//               } 
//               else{
//         if(context.mounted){ Navigator.push(context,   
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return const Mainpage();
//                   },
//                 ));}
                 
            
//               }
            
              
//             },
//             child: const Text('login'))
//             ],
//           ));
//   }
// }

// Future<dynamic> login(Username, Password) async {
//   var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//   var request = http.Request(
//       'POST', Uri.parse('https://eeeadvisorproject.com/webservice/token'));
//   request.bodyFields = {
//     'Username': '1',
//     'Password': '2',
//     'grant_type': 'password'
//   };
//   request.headers.addAll(headers);

//   http.StreamedResponse streamresponse = await request.send();

//   if (streamresponse.statusCode == 200) {
//     // print(await response.stream.bytesToString());
//  var response = await http.Response.fromStream(streamresponse);
//   final result = jsonDecode(response.body) as Map<String, dynamic>;

//   return result;

//   } 
//   else {
//       print(streamresponse.reasonPhrase);

//     return "error";
  
//   }
// }

// // class LoginData {
// //   String access_token;
// //   //  String token_type;
// //   int expires_in;
// //   LoginData({required this.access_token, required this.expires_in});

// //   factory LoginData.fromJson(Map<String, dynamic> parsedJson) {
// //     return LoginData(
// //       access_token: parsedJson['access_token'].toString(),
// //       expires_in: parsedJson['expires_in'],
// //     );
// //   }
// // }