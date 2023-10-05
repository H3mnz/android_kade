import 'dart:developer';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService._();
  static Future<String?> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log('HttpService Get => $e');
    }
    return null;
  }
}
