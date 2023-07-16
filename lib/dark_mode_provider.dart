import 'package:flutter/foundation.dart';

class DarkModeProvider extends ChangeNotifier {
  bool _darkMode = false;

  bool get isDarkMode => _darkMode;

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
}
