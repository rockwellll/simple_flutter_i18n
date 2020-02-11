import 'dart:convert';

import 'package:flutter/material.dart';

import './mixins/error_checker.dart';
import './classes/storage_loader.dart';
import './classes/storage_persister.dart';

class I18n with ChangeNotifier, ErrorChecker {
  /// the current langauge
  Map<String, dynamic> _currentLang;
  bool _isRtl = true;

  /// creates an [I18n] instance ;
  /// the [langauge] map should contain 'isRtl' key as the package is looking for that key
  I18n(Map<String, dynamic> language) {
    keyExistsOrError(language, 'isRtl');

    this._currentLang = language;
    this._isRtl = language['isRtl'];
  }

  /// [lang] returns a copy of the current langauge
  Map<String, dynamic> get lang {
    return Map.from(_currentLang);
  }

  /// returns the current boolean state of rtl in the current langauge
  bool get isRtl {
    return _isRtl;
  }

  /// updates the lanauge to [locale] object.
  /// [locale] Map must contain an 'isRtl' key as the package is looking for that key
  void setLocale(Map<String, dynamic> locale) {
    keyExistsOrError(locale, 'isRtl');

    _currentLang = locale;
    _isRtl = locale['isRtl'];

    notifyListeners();
  }

  /// loads the language from the storage , and intializes it
  void load() async {
    final loader = new StorageLoader();

    final encodedLanguage = await loader.load('language');
    final language = json.decode(encodedLanguage);

    this.setLocale(language);
  }

  ///persists the current language to the storage
  Future<bool> persist() {
    final persister = new StoragePersister();

    return persister
        .persist({'key': 'language', 'value': json.encode(this._currentLang)});
  }
}
