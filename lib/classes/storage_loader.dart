import 'package:shared_preferences/shared_preferences.dart';

import './loader.dart';

class StorageLoader implements Loader {
  @override
  Future<String> load(key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}
