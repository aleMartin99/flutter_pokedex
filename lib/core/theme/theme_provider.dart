import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/theme/theme_exports.dart';

/// ThemeProvider class
class ThemeProvider with ChangeNotifier {
  ///
  ThemeProvider(this._themeData);
  ThemeData _themeData;

  /// Get the current theme
  ThemeData getTheme() => _themeData;

  /// setTheme method
  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  /// setPrimaryColor
  void setPrimaryColor(Color newColor) {
    setTheme(
      theme().copyWith(
        primaryColor: newColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: newColor),
      ),
    );
  }
}
