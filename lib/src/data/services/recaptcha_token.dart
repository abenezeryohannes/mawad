import 'dart:convert';
import 'package:http/http.dart' as http;

class ReCaptchaV3Service {
  final String _siteKey;
  final String _action;

  ReCaptchaV3Service(this._siteKey, this._action);

  Future<String?> getRecaptchaV3Token() async {
    final response = await http.post(
      Uri.parse('https://www.google.com/recaptcha/api.js?render=$_siteKey'),
      body: {
        'action': _action,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody['token'] as String?;
    }

    return null;
  }
}
