import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  DashboardPageState createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  String username = '';
  int impression = 0;
  int ventes = 0;
  int imprimantes = 0;
  int bobines = 0;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    setState(() {
      _isLoading = true;
    });
    Api apiInstance = Api();
    String? userResponse = await apiInstance.user(context);
    print(userResponse);
    if (userResponse != null) {
      List<dynamic> users = jsonDecode(userResponse);
      for (var user in users) {
        String username = user['username'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);

        int impressionCount = 0;
        if (user['impressions'] is List<dynamic>) {
          impressionCount = user['impressions'].length;
        }

        int imprimanteCount = 0;
        if (user['imprimantes'] is List<dynamic>) {
          imprimanteCount = user['imprimantes'].length;
        }

        int venteCount = 0;
        if (user['ventes'] is List<dynamic>) {
          venteCount = user['ventes'].length;
        }

        int bobineCount = 0;
        if (user['bobines'] is List<dynamic>) {
          bobineCount = user['bobines'].length;
        }

        setState(() {
          this.username = username;
          this.impression = impressionCount;
          this.imprimantes = imprimanteCount;
          this.ventes = venteCount;
          this.bobines = bobineCount;
          _isLoading = false;
        });
      }
    } else {
      if (kDebugMode) {
        print('La méthode user a retourné null');
      }
      setState(() {
        _isLoading = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tableau de bord'),
      drawer: CustomDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('Stocks'),
                          trailing: Text('$bobines'),
                          onTap: () {
                            Navigator.pushNamed(context, '/bobine');
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.print),
                          title: Text('Impressions'),
                          trailing: Text('$impression'),
                          onTap: () {
                            Navigator.pushNamed(context, '/impressions');
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.print),
                          title: Text('Imprimantes'),
                          trailing: Text('$imprimantes'),
                          onTap: () {
                            Navigator.pushNamed(context, '/imprimante');
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('Ventes'),
                          trailing: Text('$ventes'),
                          onTap: () {
                            Navigator.pushNamed(context, '/ventes');
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
