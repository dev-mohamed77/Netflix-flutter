// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  final SharedPreferences sharedPreferences;
  SharedService({required this.sharedPreferences});

  Object? getData(String key) {
    return sharedPreferences.get(key);
  }

  Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    }
    return await sharedPreferences.setString(key, value);
  }

  Future<bool> deleteData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
