import 'dart:io';

import 'package:dr_balcony/nointernet.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
//import 'package:image/image.dart' as image;
//import 'package:flutter_svg/flutter_svg.dart';

class WebView extends StatefulWidget {
  final RouterBalcony webpage;
  const WebView({Key? key, required this.webpage}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

Future<bool> _exitApp(BuildContext context) async {
  late final PlatformWebViewControllerCreationParams params;

  // late final PlatformWebViewControllerCreationParams params;

  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    params = WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    );
  } else {
    params = const PlatformWebViewControllerCreationParams();
  }
  WebViewController controllerGlobal =
      WebViewController.fromPlatformCreationParams(params);
  //  WebViewController controllerGlobal= WebViewController.fromPlatformCreationParams(params);
  if (await controllerGlobal.canGoBack()) {
    print("onwill goback");
    controllerGlobal.goBack();
    return Future.value(false);
  } else {
    // Scaffold.of(context).showSnackBar(
    //   const SnackBar(content: Text("No back history item")),
    // );
    return Future.value(false);
  }
}

class _WebViewState extends State<WebView> {
  //int progrss=0;
  final progrss = ValueNotifier<int>(0);
  final selectedIndex = ValueNotifier<int>(0);
  
  final bnb = ValueNotifier<bool>(false);
  final firstTimeLoad= ValueNotifier<bool>(true);
 final currentUrL=ValueNotifier<String>('');
  final counterSelectedout= ValueNotifier<int>(0);
 final selectedout= ValueNotifier<bool>(false);
  final showCamera= ValueNotifier<bool>(false);


String sendUlr(){
          if (firstTimeLoad.value) {
             //selectedout.value=false;
            firstTimeLoad.value=false;
           return 'https://eeeadvisorproject.com/${widget.webpage.router}?mobile=1&v=$rand';
          }
           switch (selectedIndex.value) {
        case 0:
          {
            selectedout.value=false;
           return 'https://eeeadvisorproject.com/user?mobile=1&v=$rand#page=dashboard';
           
          }
          
        case 1:
          {
            selectedout.value=false;
              return  'https://eeeadvisorproject.com/user?mobile=1&v=$rand#page=project';
          }
          
        
        case 2:
          {
              selectedout.value=false;
       
              return  'https://eeeadvisorproject.com/user?mobile=1&v=$rand#page=profile';
          }
         
        default:
        selectedout.value=false;
        return 'https://eeeadvisorproject.com/${widget.webpage.router}?mobile=1&v=$rand';
      }
       }
  // Future <XFile?>showImagePickerdialog()async{
  //   return showDialog<XFile>(context: context, builder: (BuildContext context) {

  //      return AlertDialog(
  //     title: Text("Where Do You Want To Select Your Image From?"),
  //     actions:[
  //       TextButton(onPressed: ()async {
  //         Navigator.pop(context,await ImagePicker().pickImage(source: ImageSource.gallery));
  //       }, child: Text("From Galary")
  //       ),
  //       TextButton(onPressed: ()async {
  //         Navigator.pop(context,await ImagePicker().pickImage(source: ImageSource.camera));
  //       }, child: Text("From Camera")

  //       )
  //     ]
  //   ); }

  //   );
  // }
  //alternate
  Future<XFile?> Uploadimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<List<String>?> showImagePickerdialog64img() async {
    List<String> base64list = [];
    return showDialog<List<String>?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Where Do You Want To Select Your Image From?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      final image = await ImagePicker().pickMultiImage();
                      for (var i = 0; i < image.length; i++) {
                        String base64image =
                            base64Encode(await image[i].readAsBytes());
                        base64list.add(base64image);
                      }
                      if (mounted) {
                        Navigator.pop(context, base64list);
                      }
                    },
                    child: const Text("From Galary")),
                TextButton(
                    onPressed: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      String base64image =
                          base64Encode(await image!.readAsBytes());
                      base64list.add(base64image);
                      if (mounted) {
                        Navigator.pop(context, base64list);
                      }
                    },
                    child: const Text("From Camera"))
              ]);
        });
  }

  Future<void> sendimage(List<String>? images) async {
    final logindata = await login("1", "1");
    print(logindata);

    //final token = Auth.fromJson(jsonDecode(logindata));
    var token = logindata["access_token"];
    print(token);
    for (var i = 0; i < images!.length; i++) {
      Map<String, dynamic> jsondata = {
        "filebase64": images[i],
        "fileid": "100"
      };
      String uRL = "https://192.168.5.155:44332/webservice/document/upload";
      http.post(Uri.parse(uRL), body: jsonEncode(jsondata), headers: {
        'Authorization': 'Bearer $token',
        "content-type": "application/json"
      }).then((respons) {
        if (respons.statusCode == 200) {
          print(respons);
          print("YAY");
        } else {
          print(respons.statusCode);
          print("FAILED");
        }
      });
    }
  }

  late final WebViewController _controller;
  late final WebViewController _controller2;
  final ImagePicker picker = ImagePicker();
  late final PlatformWebViewControllerCreationParams params;
  final struuid = const Uuid().v4();
  late String rand;
  @override
  void initState() {
    rand = struuid.substring(0, 8);

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
    // final WebViewController controllersvg =
    //     WebViewController.fromPlatformCreationParams(params);
    // controllersvg
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(Colors.transparent)
    //   ..loadFlutterAsset("assets/Animated_Logo.svg");

    // _controller2 = controllersvg;

    controller
      
     
    //..currentUrl()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {

             if (!request.url.contains('#page=project')&&!request.url.contains('#page=dashboard')
             &&!request.url.contains('#page=profile')) {
                bnb.value = true;
                 if (counterSelectedout.value>=1) {
                   selectedout.value=true;
                   
                 }
                    counterSelectedout.value+=1;
              
                 return NavigationDecision.navigate;
             }else if(request.url.contains('#page=project')&&request.url.contains('#page=dashboard')
             &&request.url.contains('#page=profile')){
              bnb.value = true;
               selectedout.value=false;
               return NavigationDecision.navigate;
             }
            if (request.url.contains('user')) {
              currentUrL.value= (await controller.currentUrl())!;
              print('we are loading : $currentUrL');
              bnb.value = true;

              //debugPrint('blocking navigation to ${request.url}');

              return NavigationDecision.navigate;
            } 
            else {
              bnb.value = false;
            return NavigationDecision.navigate;
              
            }
            

            // debugPrint('allowing navigation to ${request.url}');
            // return NavigationDecision.navigate;
          },


          // onProgress: (int progress) {
          //   progrss.value = progress;

          //   //   return LinearProgressIndicator()
          //   //debugPrint('WebView is loading (progress : $progress%)');
          // },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');

            // progrss.value = 100;
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
     
          // var ss = {type:"takepi", state=0, id=:11111 }
          // switch (message.toString()) {
          //   case 'PopOut':
          //     Navigator.of(context).pop();
          //     break;
              

          //   // case "ShowBNB":
          //   // setState(() {
          //   //   bnb=true;
          //   // });
          //   // break;
          //   // case"HideBNB":
          //   //  setState(() {
          //   //   bnb=false;
          //   // });
          //   // break;
          //   default:
          // }

//           if (message.message.contains("PopOut")) {
//             Navigator.of(context).pop();
//             //   ScaffoldMessenger.of(context).showSnackBar(
//             //   SnackBar(content: Text("you have been poped out")),
//             // );
//           }
// if (message.message.contains("HideBNB")) {
//             setState(() {
//               bnb=false;
//             });
//           }

//           if (message.message.contains("ShowBNB")) {
//             setState(() {
//               bnb=true;
//             });
//           }
      //   },
      // )
      
      ..loadRequest(Uri.parse(
        sendUlr()
          // 'https://eeeadvisorproject.com/${widget.webpage.router}?mobile=1&v=$rand'
          )
          
          )
       
          
          
          ;
       controller.addJavaScriptChannel(
      'FaradidMsg',
        onMessageReceived: (JavaScriptMessage message) {
          print('Received message: ${message.message}');
          if (message.message.contains('PopOut')) {
            Navigator.of(context).pop();
            
            //   ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text("you have been poped out")),
            // );
          }   },
       );
       


    // if (bnb.value == true) {
      // switch (selectedIndex.value) {
      //   case 1:
      //     {
      //       controller.loadRequest(Uri.parse(
      //       'https://eeeadvisorproject.com/user?mobile=1&v=$rand'));
      //     }
      //     break;
      //   case 2:
      //     {
      //       controller.loadRequest(Uri.parse(
      //           'https://eeeadvisorproject.com/user/projects?mobile=1&v=$rand'));
      //     }
      //     break;
        
      //   case 3:
      //     {
      //       controller.loadRequest(Uri.parse(
      //           'https://eeeadvisorproject.com/user/profile?mobile=1&v=$rand'));
      //     }
      //     break;
      //   default:
      // }
    // }

//?ww
    //    initFilePicker() async {
    //   if (Platform.isAndroid) {
    //     final androidController = (controller.platform
    //         as AndroidWebViewController);
    //     await androidController.setOnShowFileSelector(_androidFilePicker);
    //   }
    // }
if (controller.platform is AndroidWebViewController) {
  (controller.platform as AndroidWebViewController).setOnShowFileSelector(
    (FileSelectorParams params) async {
      // Show options for selecting image from gallery or capturing a new image using camera
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Select an image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select from gallery'),
                onTap: () async {
                  Navigator.pop(context, await FilePicker.platform.pickFiles(
                    dialogTitle: "Pick your Image",
                    allowMultiple: true,
                    type: FileType.image,
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () async {
                  Navigator.pop(context, await ImagePicker().getImage(source: ImageSource.camera));
                },
              ),
            ],
          ),
        ),
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
    // if (controller.platform is AndroidWebViewController) {
      
    //   (controller.platform as AndroidWebViewController).setOnShowFileSelector(
    //     (FileSelectorParams params) async {
    //       FilePickerResult? fpr = await FilePicker.platform.pickFiles(
    //           dialogTitle: "Pick your Image",
    //           allowMultiple: true,
    //           type: FileType.image);
    //       if (fpr == null) {
    //         return [];
    //       }
    //       List<String> paths = fpr.paths
    //           .where((e) => e != null)
    //           .map((e) => 'file://${e!}')
    //           .toList();

    //       return paths;
    //     },
    //   );
    // }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    var barheight = MediaQuery.of(context).viewPadding.top;
    var height = MediaQuery.of(context).size.height;
    
    void onItemTapped(int index) {
      selectedIndex.value = index;
      // selectedIndex.value=-1;
      _controller.loadRequest(Uri.parse(
        sendUlr()
          // 'https://eeeadvisorproject.com/${widget.webpage.router}?mobile=1&v=$rand'
          ));

    }

    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        //  backgroundColor: Colors.transparent,
        //primary: ,

        body:FutureBuilder(
  future: internetCheker(),
  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    // if (snapshot.connectionState == ConnectionState.waiting) {
    //   // If the data is still loading, return a CircularProgressIndicator
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
      if (snapshot.hasError) {
      // If an error occurred while loading the data, show an error message
      return Center(
        child: Text('An error occurred: ${snapshot.error}'),
      );
    }
     else {
      // If the data has loaded successfully, check the result
      if (snapshot.data == true) {
        return WebViewWidget(controller: _controller);
      } else if(snapshot.data == false) {
        return const Nointernet();
      }
      else{
      return Container();
      }
    }
  },
),
        //  FutureBuilder(
        //   future: internetCheker(),
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //             // if(snapshot.connectionState==ConnectionState.waiting){
        //             //   return Center(
        //             //     child: Padding(
        //             //               padding: const EdgeInsets.symmetric(
        //             //                   vertical: 50, horizontal: 50),
        //             //               child: WebViewWidget(controller: _controller2),
        //             //             ),
        //             //   );}
           
        //     if (snapshot.connectionState==ConnectionState.done) {
        //       if (snapshot.data == true) {
        //         return WebViewWidget(controller: _controller);
        //       } 
        //       else if (snapshot.data == false) {

        //         return const Nointernet();
        //       }
              
        //     }
        //    return CircularProgressIndicator ();
      
           
        //   },
     
        // ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable:bnb,
              builder: (BuildContext context, value, Widget? child) {
                if (bnb.value==true) {
                  
                  return ValueListenableBuilder(
                    builder: (BuildContext context, value, Widget? child) {
                      return  ValueListenableBuilder(
                        builder: (context, value, child) {
                       return  BottomNavigationBar(
                                          currentIndex:
                                         selectedIndex.value,
                                         selectedItemColor: selectedout.value?Colors.grey[600] : Colors.blue,
                                         unselectedItemColor: Colors.grey[600],
                                          onTap: onItemTapped,
                                          type: BottomNavigationBarType.fixed,
                                          items: const <BottomNavigationBarItem>[
                         BottomNavigationBarItem(
                          icon: Icon(Icons.dashboard),
                          label: 'Dashboard',
                        ),
                      
                        BottomNavigationBarItem(
                          icon: Icon(Icons.work_rounded),
                          label: 'Projects',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.supervised_user_circle_sharp),
                          label: 'Profile',
                        ),
                        // BottomNavigationBarItem(
                        //   icon: Icon(Icons.home),
                        //   label: 'Home',
                        // ),
                                          ],
                                    );
                        },
                        valueListenable:selectedout ,
                        
                      ); },
                    valueListenable: selectedIndex,
                    
                  );
                }
                else{
                  return Container(
        height: 0,
      );
                }
                // else{
                 
                // //  return Container();
                // //here
                // }
                  },
              
            //  child: 
            )
            ,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     final img = await showImagePickerdialog64img();
        //     sendimage(img);
        //     // final XFile? image =await showImagePickerdialog();
        //     //  final List<String> base64imgs =await showImagePickerdialog();
        //     //image process
        //     // if (image!=null) {
        //     //   String base64image=base64Encode(await image.readAsBytes());
        //     // }
        //   },
        //   child: const Icon(Icons.camera_alt_rounded),
        // )
        );
  }
}

class RouterBalcony {
  String router;
  RouterBalcony(this.router);
}

Future<bool> internetCheker() async {
  bool result = await InternetConnectionChecker().hasConnection;
 // bool result2=await 
  if (result == true) {
    return true;
  } else {
    return false;
  }
}

// Future<List<String>> _androidFilePicker(FileSelectorParams params) async {

//     if (params.acceptTypes.any((type) => type == 'image/*')) {
//       final picker = ImagePicker();
//       final photo = await picker.pickImage(source: ImageSource.camera);

//       if (photo == null) {
//         return [];
//       }

//       final imageData = await photo.readAsBytes();
//       final decodedImage = image.decodeImage(imageData)!;
//       final scaledImage = image.copyResize(decodedImage, width: 500);
//       final jpg = image.encodeJpg(scaledImage, quality: 90);

//       final filePath = (await getTemporaryDirectory()).uri.resolve(
//         './image_${DateTime.now().microsecondsSinceEpoch}.jpg',
//       );
//       final file = await File.fromUri(filePath).create(recursive: true);
//       await file.writeAsBytes(jpg, flush: true);

//       return [file.uri.toString()];
//     }
//     else if (params.acceptTypes.any((type) => type == 'application/*')) {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

//       if (result != null) {
//         List<File> files = result.paths.map((path) => File(path!)).toList();
//         return files.map((file) => file.uri.toString()).toList(growable: false);
//       }
//     }
//     return [];
//   }
//  Future<List<String>> _androidFilePicker(
//       FileSelectorParams params) async {
//     try {
//       if (params.mode ==
//           FileSelectorMode.openMultiple) {
//         final attachments =
//             await FilePicker.platform.pickFiles(allowMultiple: true);
//         if (attachments == null) return [];

//         return attachments.files
//             .where((element) => element.path != null)
//             .map((e) => File(e.path!).uri.toString())
//             .toList();
//       } else {
//         final attachment = await FilePicker.platform.pickFiles();
//         if (attachment == null) return [];
//         File file = File(attachment.files.single.path!);
//         return [file.uri.toString()];
//       }
//     } catch (e, s) {

//       return [];
//     }
//   }
Future<dynamic> login(Username, Password) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request(
      'POST', Uri.parse('https://eeeadvisorproject.com/webservice/token'));
  request.bodyFields = {
    'Username': '1',
    'Password': '1',
    'grant_type': 'password'
  };
  request.headers.addAll(headers);

  http.StreamedResponse streamresponse = await request.send();

  if (streamresponse.statusCode == 200) {
    // print(await response.stream.bytesToString());
    var response = await http.Response.fromStream(streamresponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    return result;
  } else {
    print(streamresponse.reasonPhrase);
    return "error";
  }
}
// class  Auth {
//   final String access_token;
//   final String token_type;
//  final expire_in;
//   Auth( this.token_type, this.access_token, this.expire_in);

//   Auth.fromJson(Map<String, dynamic> json)
//       : access_token = json['access_token'],
//         token_type = json['token_type'],
//         expire_in =json['expire_in'];

//   Map<String, dynamic> toJson() => {
//         'access_token': access_token,
//         'token_type': token_type,
//         'token_type': expire_in,
//       };
// }
