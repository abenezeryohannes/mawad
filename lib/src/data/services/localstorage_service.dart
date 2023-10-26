import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _singleton = LocalStorageService._internal();
  late SharedPreferences _prefs;

  LocalStorageService._internal();

  factory LocalStorageService() {
    return _singleton;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    try {
      await _prefs.setString(key, value);
    } catch (e) {
      // Handle exception
      print("Error saving string: $e");
    }
  }

  // Retrieve a string value
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      // Handle exception
      print("Error fetching string: $e");
      return null;
    }
  }

  // Save an integer value
  Future<void> saveInt(String key, int value) async {
    try {
      await _prefs.setInt(key, value);
    } catch (e) {
      // Handle exception
      print("Error saving int: $e");
    }
  }

  // Retrieve an integer value
  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      // Handle exception
      print("Error fetching int: $e");
      return null;
    }
  }

  // Delete a value
  Future<void> delete(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      // Handle exception
      print("Error deleting key: $e");
    }
  }
}
