import 'dart:convert';

import 'package:mawad/src/data/services/localstorage_service.dart';

class CacheService {
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<void> addToCache(String key, dynamic value) async {
    String json = jsonEncode(value);
    await _localStorageService.saveString(key, json);
  }

  Future<dynamic> getFromCache(String key) async {
    String? json = _localStorageService.getString(key);
    return json == null ? null : jsonDecode(json);
  }

  Future<void> invalidateCache(String key) async {
    await _localStorageService.delete(key);
  }

  Future<bool> isCached(String key) async {
    return _localStorageService.getString(key) != null;
  }

  Future<void> clearCache() async {}
}
