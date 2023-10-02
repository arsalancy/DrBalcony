import 'dart:io';
import 'package:DrBalcony/repository/sqlite.dart';
import 'package:path/path.dart' as path;
import 'package:DrBalcony/screens/web_view/webviewUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileUploadQueueProvider extends ChangeNotifier {
  List<String> fileQueue = []; // Queue to hold file paths

  bool get isUploading =>
      fileQueue.isNotEmpty; // Check if there are files in the queue

  // void addToQueue(String submitId, String filePath, int count) {
  //   fileQueue.add(filePath);
  //   if (fileQueue.length == 1) {
  //     // If the queue was empty, start the upload process
  //     _processQueue(submitId, count);
  //   }
  //   notifyListeners();
  // }
  Future<void> addToQueue(String submitId, String filePath, int count) async {
    if (!fileQueue.contains(filePath)) {
      fileQueue.add(filePath);
    }
    // if (fileQueue.length == 1) {
    // If the queue was empty, start the upload process
    await _processQueue(submitId, count);
    // }
    notifyListeners();
  }

  Future<void> _processQueue(String submitId, int count) async {
    String? token = await storage.read(key: 'token');
    while (fileQueue.isNotEmpty) {
      final filePath = fileQueue[0];
      final file = File(filePath);

      if (file.existsSync()) {
        final isSent = await uploadFile(submitId, filePath, count, token!);
        if (isSent) {
          file.delete();
          // File uploaded successfully, remove it from the queue
          fileQueue.removeAt(0);
        } else {
          // File upload failed, you can handle the error or retry if needed
          fileQueue.removeAt(0);
          break;
        }
      } else {
        // File doesn't exist, remove it from the queue
        fileQueue.removeAt(0);
      }
    }
    notifyListeners();
  }
  // void _processQueue(String submitId, int count) async {
  //   while (fileQueue.isNotEmpty) {
  //     final filePath = fileQueue[0];
  //     final isSent = await uploadFile(submitId, filePath, count);
  //     if (isSent) {
  //       // File uploaded successfully, remove it from the queue
  //       fileQueue.removeAt(0);
  //     } else {
  //       // File upload failed, you can handle the error or retry if needed
  //       break;
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<bool> uploadFile(
      String submitId, String filePath, int count, String token) async {
    final url = 'https://drbalcony.com/api/uploadDocument';
    late http.StreamedResponse response;
    // String fileExtension = path.extension(filePath);
    File file = File(filePath);

    if (!file.existsSync()) {
      print('File does not exist');
      return false;
    }

    final headers = {
      'Authorization': apiKey,
      'token': token,
    };

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['submitId'] = submitId;
    //  request.fields['ext'] = fileExtension;
    request.fields['count'] = count.toString();
    request.files.add(await http.MultipartFile.fromPath('File', filePath));

    try {
      response = await request.send();
      if (response.statusCode == 200) {
        //hanel it when gets deleted?

        return true;
      } else if (response.statusCode == 404) {
        DBHelper dbhelper = DBHelper();
        await dbhelper.deleteProject(int.parse(submitId));
        await deleteInvalidDirectories();
      }

      print(response.reasonPhrase);
    } catch (e) {
      print(e);
    }

    return false;
  }
}
