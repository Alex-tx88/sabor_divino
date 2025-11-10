import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool get isAuthenticated => _token != null;
  String? get token => _token;
  final String _baseUrl = "http://localhost:8080/api"; 
  final _storage = const FlutterSecureStorage();
  Future<void> tryAutoLogin() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) {
      _token = token;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token']; 
        
        await _storage.write(key: 'jwt_token', value: _token);
        notifyListeners();
      } else {
        // Tratar erro (ex: senha incorreta)
        throw Exception('Falha ao fazer login');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Sucesso
      } else {
        // Tratar erro (ex: email já existe)
        throw Exception('Falha ao registrar');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    await _storage.delete(key: 'jwt_token');
    notifyListeners();
  }
}