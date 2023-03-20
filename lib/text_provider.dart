import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  String _text = '';
  String get text => _text;

  void setText(String text) {
    _text = text;
    notifyListeners();
  }

  void addChunk(String chunk) {
    _text = (text + chunk);
    notifyListeners();
  }

  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  set isWaiting(bool value) {
    _isWaiting = value;
    notifyListeners();
  }
}
