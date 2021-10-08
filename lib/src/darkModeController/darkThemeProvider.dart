// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:quran/src/darkModeController/darkThemePref.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePref darkThemePref = DarkThemePref();

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePref.setDarkTheme(value);

    notifyListeners();
  }
}
