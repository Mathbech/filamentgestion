import 'package:flutter/foundation.dart';
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
  String username = '';
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    Api apiInstance = Api();
    String? Username = await apiInstance.user(context);
    print(Username);
    if (Username != null) {
      username = Username;
    } else {
      if (kDebugMode) {
        print('La méthode user a retourné null');
      }
      return null;
    }
    setState(() {});
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
              icon: const Icon(Icons.sell_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/ventes');
              },
            ),
            IconButton(
              icon: const Icon(Icons.storage),
              onPressed: () {
                Navigator.pushNamed(context, '/bobine');
              },
            ),
            
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Api apiInstance = Api();
                apiInstance.logout(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Bienvenue ${username} !'),
        ),
        );
  }
}
