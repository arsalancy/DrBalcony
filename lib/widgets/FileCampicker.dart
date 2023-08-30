import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileCamPicker extends StatelessWidget {
  const FileCamPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select an Image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.blue),
            title: const Text('Select from gallery'),
            onTap: () async {
              Navigator.pop(
                  context,
                  await FilePicker.platform.pickFiles(
                    allowCompression: true,
                    dialogTitle: "Pick your Image",
                    allowMultiple: true,
                    type: FileType.image,
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.camera_alt,
              color: Colors.blue,
            ),
            title: const Text('Take a photo'),
            onTap: () async {
              Navigator.pop(context,
                  await ImagePicker().getImage(source: ImageSource.camera));
            },
          ),
        ],
      ),
    );
  }
}
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';

// class FileCamPicker extends StatelessWidget {
//   const FileCamPicker({
//     Key? key,
//   }) : super(key: key);

//   Future<String> compressSelectedFile(String filePath) async {
//     ImageProperties properties =
//         await FlutterNativeImage.getImageProperties(filePath);
//     File compressedFile = await FlutterNativeImage.compressImage(
//       filePath,
//       quality: 80,
//       targetWidth: properties.width!,
//       targetHeight: properties.height!,
//     );

//     // Use the compressed file as needed (e.g., upload to a server)
//     print('Original file path: $filePath');
//     print('Compressed file path: ${compressedFile.path}');
//     return compressedFile.path;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Select an image'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.photo_library, color: Colors.blue),
//             title: const Text('Select from gallery'),
//             onTap: () async {
//               String compressedfile = "";
//               FilePickerResult? result = await FilePicker.platform.pickFiles(
//                 allowCompression: false, // Disable internal compression
//                 dialogTitle: "Pick your Image",
//                 allowMultiple: true,
//                 type: FileType.image,
//               );

//               if (result != null && result.files.isNotEmpty) {
//                 PlatformFile file = result.files.first;

//                 if (file.size! > 0) {
//                   compressedfile = await compressSelectedFile(file.path!);
//                 } else {
//                   // Handle empty file
//                   print('Selected file is empty');
//                 }
//               } else {
//                 // Handle file picking cancellation
//                 print('File picking was canceled');
//               }

//               Navigator.pop(context, compressedfile);
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.camera_alt,
//               color: Colors.blue,
//             ),
//             title: const Text('Take a photo'),
//             onTap: () async {
//               final imagePicker = ImagePicker();
//               final PickedFile? pickedFile =
//                   await imagePicker.getImage(source: ImageSource.camera);

//               if (pickedFile != null) {
//                 compressSelectedFile(pickedFile.path);
//               } else {
//                 // Handle image capture cancellation
//                 print('Image capture was canceled');
//               }

//               Navigator.pop(context, pickedFile);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


//--------------------------------------------------Doc--------------------------------------------------\\
/*
This code defines a Flutter widget called `FileCamPicker`, which displays an `AlertDialog` with options to select an image from the gallery or take a photo using the camera.

Here's a breakdown of what the code does:

- The code imports necessary dependencies, including `file_picker.dart` from the `file_picker` package and `image_picker.dart` from the `image_picker` package.

- The `FileCamPicker` class is defined, which extends `StatelessWidget`.

- The constructor of `FileCamPicker` is defined with the `super.key` parameter. The `super` keyword is used to call the constructor of the superclass (`StatelessWidget` in this case).

- The `build` method is overridden to build the UI of the widget. It returns an `AlertDialog` widget that displays a dialog box with a title and content.

- The content of the dialog is a `Column` widget containing two `ListTile` widgets.

  - The first `ListTile` represents the option to select an image from the gallery. It displays an icon (`Icons.photo_library`), a title (`Select from gallery`), and an `onTap` callback function. When tapped, it uses the `FilePicker.platform.pickFiles` method to open a file picker that allows the user to select an image file from the gallery. The selected file is then returned using `Navigator.pop` to close the dialog.

  - The second `ListTile` represents the option to take a photo using the camera. It displays an icon (`Icons.camera_alt`), a title (`Take a photo`), and an `onTap` callback function. When tapped, it uses the `ImagePicker().getImage` method to open the device camera and capture a photo. The captured image is then returned using `Navigator.pop` to close the dialog.

The purpose of this code is to provide a reusable widget that allows users to select an image from the gallery or take a photo using the camera. It simplifies the process of handling image selection and capturing within a Flutter application by encapsulating the functionality within a single widget.
*/

