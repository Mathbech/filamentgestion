import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  token() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  login(data) async {
    var fullUrl = 'https://filamentgestion.local:4443/auth';

    Response response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }
}

class Api {
  token() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  login(data) async {
    var fullUrl = 'https://filamentgestion.local:4443/api' + await token();

    Response response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }
}

class Logout {
  Logout(BuildContext context);

  logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Navigator.pushNamed(context, '/login');
  }
}