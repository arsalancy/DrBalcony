import 'package:flutter/material.dart';

class CopyingProcessState extends ChangeNotifier {
  bool _isCopying = false;

  bool get isCopying => _isCopying;

  void startCopying() {
    _isCopying = true;
    notifyListeners();
  }

  void stopCopying() {
    _isCopying = false;
    notifyListeners();
  }
}
