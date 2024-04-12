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
    if (kDebugMode) {
      print(users);
    }

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    if (users.isNotEmpty) {
      for (var user in users) {
        if (user.containsKey('username')) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', user['username']);
          return user['username'];
        } else {
          if (kDebugMode) {
            print(
                'La clé "username" n\'existe pas dans le corps de la réponse');
          }
        }
      }
    }else{
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }
  }

  bobine(BuildContext context) async {
    var fullUrl = 'https://filamentgestion.local:4443/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = json.decode(response.body);
    if (kDebugMode) {
      print(users);
    }

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    List<String> bobines = [];
    for (var user in users) {
      if (user.containsKey('bobines')) {
        for (var bobineId in user['bobines']) {
          var bobineUrl = 'https://filamentgestion.local:4443$bobineId';
          Response bobineResponse =
              await http.get(Uri.parse(bobineUrl), headers: {
            'accept': 'application/json',
            HttpHeaders.authorizationHeader: await getToken(),
          });
          if (bobineResponse.statusCode == 200) {
            var bobine = json.decode(bobineResponse.body);
            bobines.add(bobine.toString());
          }
        }
      }
    }

    if (kDebugMode) {
      print('La liste des bobines est : $bobines');
    }

    return bobines;
  }

  vente(BuildContext context) async {
    var fullUrl = 'https://filamentgestion.local:4443/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = json.decode(response.body);
    if (kDebugMode) {
      print(users);
    }

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    List<String> ventes = [];
    for (var user in users) {
      if (user.containsKey('ventes')) {
        for (var ventesId in user['ventes']) {
          var bobineUrl = 'https://filamentgestion.local:4443$ventesId';
          Response bobineResponse =
              await http.get(Uri.parse(bobineUrl), headers: {
            'accept': 'application/json',
            HttpHeaders.authorizationHeader: await getToken(),
          });
          if (bobineResponse.statusCode == 200) {
            var bobine = json.decode(bobineResponse.body);
            ventes.add(bobine.toString());
          }
        }
      }
    }

    if (kDebugMode) {
      print('La liste des bobines est : $ventes');
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
