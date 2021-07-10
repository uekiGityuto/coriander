import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  String kboyText = 'Kboy';

  void changeKboyText() {
    kboyText = 'waito';
    notifyListeners();
  }
}