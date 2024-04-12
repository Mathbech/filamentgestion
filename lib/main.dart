import '/template/dashboard/index.dart';
import 'package:flutter/material.dart';
import 'template/login/widget/index.dart';
import 'template/dashboard/bobine.dart';
import 'template/dashboard/ventes.dart';
import 'template/dashboard/imprimantes.dart';
import 'template/dashboard/impressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String initialRoute = '/';
  if (prefs.getString('token') != null) {
    initialRoute = '/dashboard';
  }
  runApp(MainApp(initialRoute: initialRoute));
}

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/bobine': (context) => const BobinePage(),
        '/ventes': (context) => const VentePage(),
        '/imprimante': (context) => const ImprimantePage(),
        '/impressions': (context) => const ImpressionsPage(),
      },
    );
  }
}
