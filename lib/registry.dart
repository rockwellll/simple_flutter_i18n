/// The place where you register the applications langauge
/// the I18n provider has direct contact with this class
class I18nRegistry {
  /// the langaugse of the application
  /// langauges are added to the regisry using the
  /// [I18nRegistry.register]
  static Map<String, Map<String, dynamic>> langs = {};

  /// the initial language of the application
  static Map<String, dynamic> _initialLanguage = {};

  /// sets the initialLanguage of the application
  static void setInitialLanguage(Map<String, dynamic> language) {
    _initialLanguage = language;
  }

  /// register a langauge to the registry
  /// expects a key-value pair to be received
  static void register(String key, Map<String, dynamic> language) {
    langs[key] = language;
  }

  /// check if the langauges map is empty or not
  static bool isEmpty() {
    return langs.length == 0;
  }

  /// this getter is used by the I18n provider
  /// checks if the registry is empty
  /// and throws error if it is
  static get initialLanguage {
    if (I18nRegistry.isEmpty()) {
      throw Exception(
        "you didint register any languages, please regersiter em",
      );
    }
    return _initialLanguage;
  }
}
