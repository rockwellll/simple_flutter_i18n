import 'dart:convert';

import 'package:flutter/material.dart';

import './mixins/error_checker.dart';
import './classes/storage_loader.dart';
import './classes/storage_persister.dart';
import './registry.dart';

class I18n with ChangeNotifier, ErrorChecker {
  /// the current langauge
  Map<String, dynamic> _currentLang = {};
  bool _isRtl = true;

  I18n() {
    this._currentLang = I18nRegistry.initialLanguage;
    this._isRtl = I18nRegistry.initialLanguage['isRtl'];
  }

  /// [lang] returns a copy of the current langauge
  Map<String, dynamic> get lang {
    return Map.from(_currentLang);
  }

  /// returns the current boolean state of rtl in the current langauge
  bool get isRtl {
    return _isRtl;
  }

  /// updates the lanauge to [locale] String.
  /// [locale] must be a string that is registerd throgh [Registry.register] method
  /// the method will perform a call to [I18n.persist] to persist the langauge
  Future<bool> setLocale(String key) {
    keyExistsOrError(I18nRegistry.langs[key], 'isRtl');

    _currentLang = I18nRegistry.langs[key];
    _isRtl = I18nRegistry.langs[key]['isRtl'];

    notifyListeners();

    return this.persist();
  }

  /// called internally when loading the langauge from storage
  void _setLocaleFromStorage(Map<String, dynamic> values) {
    _currentLang = values;
    _isRtl = values['isRtl'];

    notifyListeners();
  }

  /// loads the language from the storage , and intializes it
  /// [fallback] will be used in case no language was found
  Future<bool> load({@required Map<String, dynamic> fallback}) async {
    keyExistsOrError(fallback, 'isRtl');

    final loader = new StorageLoader();

    final encodedLanguage = await loader.load('language');

    this._setLocaleFromStorage(
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
