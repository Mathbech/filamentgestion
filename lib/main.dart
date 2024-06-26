import '/template/dashboard/index.dart';
import 'package:flutter/material.dart';
import 'template/login/widget/index.dart';
import 'template/bobines/bobine.dart';
import 'template/ventes/ventes.dart';
import 'template/imprimantes/imprimantes.dart';
import 'template/impressions/impressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/data_loader.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String initialRoute = '/';
  if (prefs.getString('token') != null) {
    initialRoute = '/dashboard';
  }
  DataLoader().fetchAndStoreData();
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
