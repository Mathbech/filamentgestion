import 'package:filamentgestion/template/dashboard/index.dart';
import 'package:flutter/material.dart';
import 'template/login/widget/index.dart';
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

// void main() {
//   HttpOverrides.global = new MyHttpOverrides();
//   runApp(const MainApp());
// }

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized(); // Assurez-vous d'appeler cette méthode si vous utilisez `async` dans `main`
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
      title: 'Flutter Template',

      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
