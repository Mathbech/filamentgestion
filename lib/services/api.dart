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
    var fullUrl = 'https://std22.beaupeyrat.com/auth';

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
    var fullUrl = 'https://std22.beaupeyrat.com/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = response.body;

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    if (users.isNotEmpty) {
      return users;
    } else {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }
  }

  bobine(BuildContext context) async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = json.decode(response.body);

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
          var bobineUrl = 'https://std22.beaupeyrat.com$bobineId';
          Response bobineResponse =
              await http.get(Uri.parse(bobineUrl), headers: {
            'accept': 'application/json',
            HttpHeaders.authorizationHeader: await getToken(),
          });
          if (bobineResponse.statusCode == 200) {
            print(bobineResponse.body);
            var bobine = bobineResponse.body;
            bobines.add(bobine.toString());
          }
        }
      }
    }

    return bobines;
  }

  vente(BuildContext context) async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = json.decode(response.body);

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
          var bobineUrl = 'https://std22.beaupeyrat.com$ventesId';
          Response bobineResponse =
              await http.get(Uri.parse(bobineUrl), headers: {
            'accept': 'application/json',
            HttpHeaders.authorizationHeader: await getToken(),
          });
          if (bobineResponse.statusCode == 200) {
            var vente = bobineResponse.body;
            ventes.add(vente.toString());
          }
        }
      }
    }

    return ventes;
  }

  imprimante(BuildContext context) async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final users = json.decode(response.body);

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }

    List<String> imprimante = [];
    for (var user in users) {
      if (user.containsKey('imprimantes')) {
        for (var imprimanteId in user['imprimantes']) {
          var imprimanteUrl = 'https://std22.beaupeyrat.com$imprimanteId';
          Response imprimantesResponse =
              await http.get(Uri.parse(imprimanteUrl), headers: {
            'accept': 'application/json',
            HttpHeaders.authorizationHeader: await getToken(),
          });
          if (imprimantesResponse.statusCode == 200) {
            var imprimantes = imprimantesResponse.body;
            imprimante.add(imprimantes.toString());
            if (kDebugMode) {
              print(imprimantes);
            }
          }
        }
      }
    }

    return imprimante;
  }

  impressions(BuildContext context) async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/users';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });
    final users = json.decode(response.body);

    if (response.statusCode == 401) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      if (kDebugMode) {
        print('Token removed');
      }
      Navigator.pushNamed(context, '/');
    }
    List<String> impressions = [];
    for (var user in users) {
      if (user.containsKey('impressions')) {
        for (var impressionId in user['impressions']) {
          var impressionUrl = 'https://std22.beaupeyrat.com$impressionId';
          Response impressionResponse =
              await http.get(Uri.parse(impressionUrl), headers: {
            'accept': 'application/json',
            HttpHeaders.authorizationHeader: await getToken(),
          });
          if (impressionResponse.statusCode == 200) {
            var impression = impressionResponse.body;
            impressions.add(impression.toString());
          }
        }
      }
    }

    return impressions;
  }

  // récupérer les couleurs
  getColors() async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/couleurs';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final colors = json.decode(response.body);

    return colors;
  }

  // récupérer les catégories
  getCategories() async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/categories';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final categories = json.decode(response.body);

    return categories;
  }

  getImprimante() async {
    var fullUrl = 'https://std22.beaupeyrat.com/api/imprimantes';
    Response response = await http.get(Uri.parse(fullUrl), headers: {
      'accept': 'application/json',
      HttpHeaders.authorizationHeader: await getToken(),
    });

    final imprimantes = json.decode(response.body);

    return imprimantes;
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
