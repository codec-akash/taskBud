import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;

  bool get isAuth {
    // print("object");
    print('AuthToken$token');
    return token != null;
  }

  String get token {
    if (_token != null) {
      // print("object");
      print('Token$_token');
      return _token;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    print(email);
    final url = "http://10.0.2.2:3000/user/login";
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      print(response);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      _token = responseData['token'];
      print('Hello$_token');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', _token);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup({
    String email,
    String password,
    String name,
    String phone,
  }) async {
    final url = "http://10.0.2.2:3000/user/register";
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
            'name': name,
            'phonenumber': phone
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      _token = responseData['token'];
      print('Hello$_token');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', _token);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    print("AutoLogin");
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("authToken")) {
      return false;
    }
    _token = prefs.getString("authToken");
    print("object$_token");
    if (_token == null) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
