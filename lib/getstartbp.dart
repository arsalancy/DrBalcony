// import 'package:dr_balcony/webview.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';

// class GetStart extends StatelessWidget {
//   const GetStart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final Uri url = Uri.parse('https://www.drbalcony.com');
//     launchURL() async {
//       var uri = Uri.parse("https://drbalcony.com");
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         // can't launch url
//       }
//     }

//     var sw = MediaQuery.of(context).size.width;
//     var sh = MediaQuery.of(context).size.height;
//      var barheight = MediaQuery.of(context).viewPadding.top;
//     return Scaffold(
//         // appBar: AppBar(
//         //   backgroundColor: Colors.grey[300],
//         //   title: Image.asset("assets/logo.png"),
//         // ),
//         body: Stack(
//           //  alignment: Alignment.center,
//           children: [
            
//             Image.asset(
//               "assets/balcony.jpg",
//               alignment: Alignment.topLeft,
//               fit: BoxFit.cover,
//               height: double.infinity,
//             ),
//             // Container(
//             //   color:Color.fromARGB(255, 219, 219, 219) ,
//             //   height: sw,
//             // ),
//             Container(
             
//               decoration: BoxDecoration(color: Color.fromARGB(255, 219, 219, 219)),
//               child: Padding(
//                 padding:  EdgeInsets.fromLTRB(10, 5+barheight, 10, 5),
//                 child: SizedBox(
//                   width: sw,
//                   height: sw/8,
//                   child: Image.asset("assets/logo.png",fit: BoxFit.contain,)),
//               )),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                    const SizedBox( height: 20,),
//                   Text(
//                     "EXTERIOR\nELEVATED\nELEMENTS\n",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: sw/9.5
//                         ,
//                         color: Colors.brown.shade700),
//                   ),
//                   FittedBox(
//                     fit: BoxFit.fitWidth,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                           color: Color.fromARGB(130, 146, 75, 0),
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15))),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           "30+ Years Of Experience",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 40,
//                               color: Color.fromARGB(255, 255, 255, 255)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                         color: Color.fromARGB(130, 146, 75, 0),
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(15),
//                             bottomRight: Radius.circular(15))),
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: FittedBox(
//                         fit: BoxFit.fitWidth,
//                         child: Text(
//                           "Engineering Balcony Inspection SB721 & SB326COMPLY\n WITH THE ORDINANCE EASY WITH A FREE CONSULTATION",
//                           style: TextStyle(
//                               fontSize: 40,
//                               color: Color.fromARGB(255, 255, 255, 255)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: sw/3,
//                     child: ElevatedButton(
//                       style: const ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll<Color>(
//                             Color.fromARGB(255, 255, 208, 0)),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>  WebView(webpage:RouterBalcony("newproject"),),
                          
//                         ));
//                       },
//                       child:  Text(
//                         "New Project",
//                         style: TextStyle(
//                           fontSize: sw/25,
//                           color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: sw/3,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => WebView(webpage:RouterBalcony("login") ,),
                          
//                         ));
//                       },
//                       child:  Text("Login"
//                       ,style: TextStyle(
//                           fontSize: sw/25,
//                           )
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: sw/3,
//                     child: ElevatedButton(
//                       onPressed: launchURL,
//                       child:  Text("Website",
//                       style: TextStyle(
//                           fontSize: sw/25,
//                           ),),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }
