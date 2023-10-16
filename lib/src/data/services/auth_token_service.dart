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
    final token = _localStorage.getString('auth_token');
    if (token != null) {
      _apiService.setToken(token);
    } else {
      await login(email: "123456789", password: "123456789");
    }
  }

  Future<void> login({required String email, required String password}) async {
    final response = await _apiService
        .postRequest('/auth/sign-in', {"email": email, "password": password});
    if (response.containsKey('accessToken')) {
      await saveToken(response['accessToken']);
      _apiService.setToken(response['accessToken']);
    }
  }

  Future<void> saveToken(String token) async {
    await _localStorage.saveString('auth_token', token);
  }

  Future<void> refreshToken() async {}

  Future<void> logout() async {
    _apiService.clearToken();
    await _localStorage.delete('auth_token');
  }
}
