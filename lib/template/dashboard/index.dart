import 'package:flutter/material.dart';
import '../../services/api.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  DashboardPageState createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          // méthode de logout
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Logout(context);
              },
            ),
          ],
        ),
        body: const Center(
          child: Text('Bienvenue  (variable user) !'),
        )
      );
  }
}
