import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/data/services/api_serives.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';

class AuthTokenService {
  static final AuthTokenService _singleton = AuthTokenService._internal();
  final ApiService _apiService = ApiService();
  final LocalStorageService _localStorage = LocalStorageService();

  AuthTokenService._internal();

  factory AuthTokenService() => _singleton;

  Future<void> initialize() async {
    await _localStorage.initialize();
    final token = _localStorage.getString(AppConstants.ACCESS_TOKEN);
    if (token != null) {
      _apiService.setToken(token);
    } else {}
  }

  Future<void> saveToken(String token) async {
    await _localStorage.saveString(AppConstants.ACCESS_TOKEN, token);
  }

  Future<bool> hasToken() async {
    final token = _localStorage.getString(AppConstants.ACCESS_TOKEN);
    return token != null && token.isNotEmpty;
  }

  Future<void> refreshToken() async {
    final token = _localStorage.getString(AppConstants.ACCESS_TOKEN);
    if (token != null) {
      _apiService.setToken(token);
    }
  }

  Future<void> logout() async {
    _apiService.clearToken();
    await _localStorage.delete(AppConstants.ACCESS_TOKEN);
  }
}
