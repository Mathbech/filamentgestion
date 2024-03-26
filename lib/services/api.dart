import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
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

  user(BuildContext context) async {
    print(token);
    var fullUrl =
        'https://filamentgestion.local:4443/api/users';
    Response response = await http.get(
      Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorizationHeader': 'Bearer ' + await token(),
      },
    );

    var body = json.decode(response.body);

    if (body['code'] == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      print('Token removed');
      Navigator.pushNamed(context, '/');
    }
    if (body.containsKey('username')) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', body['username']);
      return body['username'];
    } else {
      print('La clé "username" n\'existe pas dans le corps de la réponse');
      return null;
    }
  }

  logout(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    print('Token removed');
    Navigator.pushNamed(context, '/');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vous avez été déconnecté'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
