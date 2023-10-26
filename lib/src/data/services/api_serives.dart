import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiService {
  final String _baseUrl = 'http://ordermawad.com/api/v1';
  String? _token;

  ApiService._internal();
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() => _singleton;

  void setToken(String token) => _token = token;
  void clearToken() => _token = null;

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_token != null) headers['Authorization'] = 'Bearer $_token';
    return headers;
  }

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    return await _makeRequest(
        () => http.get(Uri.parse('$_baseUrl$endpoint'), headers: _headers));
  }

  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    return await _makeRequest(() => http.post(Uri.parse('$_baseUrl$endpoint'),
        body: json.encode(body), headers: _headers));
  }

  Future<Map<String, dynamic>> uploadImage(
      String endpoint, File imageFile) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('$_baseUrl$endpoint'));
    request.headers.addAll(_headers);
    final mimeTypeData = lookupMimeType(imageFile.path)!.split('/');
    final multipartFile = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    request.files.add(multipartFile);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _makeRequest(
      Future<http.Response> Function() requestFn) async {
    try {
      final response = await requestFn();
      log(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw ApiException(errorData['message'] ?? 'Unknown error occurred.');
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      } else {
        throw ApiException(e.toString());
      }
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
