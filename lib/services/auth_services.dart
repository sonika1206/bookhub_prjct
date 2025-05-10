import 'dart:convert';
import 'package:bookhub_prjct/models/token.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
class AuthService {
  Future<Token?> login(String username, String password) async {
    try {
      final url = Uri.parse('https://apis.ccbp.in/login');
      final response = await http.post(
        url,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final box = Hive.box<Token>('authBox');
        final token = Token.fromJson(jsonDecode(response.body));
        await box.put('token', token);
        return token;
      } else {
        throw Exception('Login failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    final box = Hive.box<Token>('authBox');
    await box.delete('token');
  }

  Future<bool> isAuthenticated() async {
     final box = Hive.box<Token>('authBox');
    return box.isNotEmpty;
  }

  Future<Token?> getToken() async {
    final box = Hive.box<Token>('authBox');
    return box.get('token');
  }
}