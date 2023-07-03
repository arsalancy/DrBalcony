
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
      title: const Text('Select an image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:
                const Icon(Icons.photo_library, color: Colors.blue),
            title: const Text('Select from gallery'),
            onTap: () async {
              Navigator.pop(
                  context,
                  await FilePicker.platform.pickFiles(
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
              Navigator.pop(
                  context,
                  await ImagePicker()
                      .getImage(source: ImageSource.camera));
            },
          ),
        ],
      ),
    );
  }
}

