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
  /// [setLocale] also calls [I18n().persist] to persist the language
  void setLocale(Map<String, dynamic> locale) {
    keyExistsOrError(locale, 'isRtl');

    _currentLang = locale;
    _isRtl = locale['isRtl'];

    notifyListeners();
  }

  /// loads the language from the storage , and intializes it
  /// [fallback] will be used in case no language was found
  Future<bool> load({@required Map<String, dynamic> fallback}) async {
    final loader = new StorageLoader();

    final encodedLanguage = await loader.load('language');

    this.setLocale(
      encodedLanguage == null
          ? fallback
          : json.decode(
              encodedLanguage,
            ),
    );

    return this.persist();
  }

  ///persists the current language to the storage
  Future<bool> persist() {
    final persister = new StoragePersister();

    return persister
        .persist({'key': 'language', 'value': json.encode(this._currentLang)});
  }
}
