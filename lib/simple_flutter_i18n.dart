import 'package:flutter/material.dart';

class I18n with ChangeNotifier {
  /// the current langauge
  Map<String, dynamic> _currentLang;
  bool _isRtl = true;

  /// creates an [I18n] instance ;
  /// the [langauge] map should contain 'isRtl' key as the package is looking for that key
  I18n(Map<String, dynamic> language) {
    this._currentLang = language;
    this._isRtl = language['isRtl'];
  }

  /// [lang] returns a copy of the current langauge
  Map<String, dynamic> get lang {
    return { ..._currentLang};
  }

  /// returns the current boolean state of rtl in the current langauge
  bool get isRtl {
    return _isRtl;
  }

  /// updates the lanauge to [langauge] object.
  /// the [langauge] Map must contain an 'isRtl' key as the package is looking for that key
  void changeLanguageTo(Map<String, dynamic> langauge) {
    _currentLang = langauge;
    _isRtl = langauge['isRtl'];

    notifyListeners();
  }
}
