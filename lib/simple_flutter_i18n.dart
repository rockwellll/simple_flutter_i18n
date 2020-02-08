import 'package:flutter/material.dart';


class I18n with ChangeNotifier {
  Map<String, dynamic> _currentLang;
  bool _isRtl = true;

  I18n(Map<String, dynamic> language) {
    this._currentLang = language;
    this._isRtl = language['isRtl'];
  }

  Map<String, dynamic> get lang {
    return { ..._currentLang};
  }

  bool get isRtl {
    return _isRtl;
  }
 
  void changeLanguageTo(Map<String, dynamic> langauge) {
    _currentLang = langauge;
    _isRtl = langauge['isRtl'];

    notifyListeners();
  }
}
