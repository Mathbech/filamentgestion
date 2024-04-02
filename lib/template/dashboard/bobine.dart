import 'package:flutter/material.dart';
import '../../services/api.dart';

class BobinePage extends StatefulWidget {
  const BobinePage({super.key});

  static const String routeName = '/bobine';

  @override
  BobinePageState createState() {
    return BobinePageState();
  }
}

class BobinePageState extends State<BobinePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bobine'),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          // méthode de logout
          actions: <Widget>[
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
          // liste des bobines
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Bobine 1'),
                subtitle: Text('Référence: 123456'),
                onTap: () {
                  //Navigator.pushNamed(context, '/bobine/1');
                },
              ),
              ListTile(
                title: Text('Bobine 2'),
                subtitle: Text('Référence: 123457'),
                onTap: () {
                  //Navigator.pushNamed(context, '/bobine/2');
                },
              ),
              ListTile(
                title: Text('Bobine 3'),
                subtitle: Text('Référence: 123458'),
                onTap: () {
                  //Navigator.pushNamed(context, '/bobine/3');
                },
              ),
            ],
          ),
        ));
  }
}
