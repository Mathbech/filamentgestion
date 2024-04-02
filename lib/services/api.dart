import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return 'Bearer $token';
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
    var fullUrl = 'https://filamentgestion.local:4443/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = json.decode(response.body);
    if(kDebugMode){
      print(users);
    }

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode){
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    for (var user in users) {
      if (user.containsKey('username')) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', user['username']);
        return user['username'];
      } else {
        if(kDebugMode){
          print('La clé "username" n\'existe pas dans le corps de la réponse');
        }
        return null;
      }
    }
  }

  bobine(BuildContext context) async {
    var fullUrl = 'https://filamentgestion.local:4443/api/bobines';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final bobines = json.decode(response.body);
    if(kDebugMode){
      print(bobines);
    }

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode){
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    return bobines;
  }


  vente(BuildContext context) async {
    var fullUrl = 'https://filamentgestion.local:4443/api/ventes';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final ventes = json.decode(response.body);
    if (kDebugMode) {
      print(ventes);
    }

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    return ventes;
  }

  logout(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    print('Token removed');
    Navigator.pushNamed(context, '/');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vous avez été déconnecté'),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
