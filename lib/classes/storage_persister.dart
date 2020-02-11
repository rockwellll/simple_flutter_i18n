import 'package:shared_preferences/shared_preferences.dart';

import './persister.dart';

class StoragePersister implements Persister {
  @override
  Future<bool> persist(data) async {
    final prefs = await SharedPreferences.getInstance();

    return await prefs.setString(data['key'], data['value']);
  }
}
