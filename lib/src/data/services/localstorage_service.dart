import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _singleton = LocalStorageService._internal();
  SharedPreferences? _prefs;

  LocalStorageService._internal();

  factory LocalStorageService() => _singleton;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Retrieve a string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save an integer value
  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Retrieve an integer value
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Delete a value
  Future<void> delete(String key) async {
    await _prefs?.remove(key);
  }
}
