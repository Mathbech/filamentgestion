import 'package:flutter/foundation.dart';
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
  List<String> bobines = [];
  @override
  void initState() {
    super.initState();
    getBobines();
  }

  Future<void> getBobines() async {
    Api apiInstance = Api();
    List<dynamic>? tempBobines = await apiInstance.bobine(context);
    if (tempBobines != null) {
      bobines = tempBobines.map((bobine) => bobine.toString()).toList();
      print(bobines);
    } else {
      if (kDebugMode) {
        print('La méthode bobine a retourné null');
      }
      return null;
    }
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
          child: const Icon(Icons.home),
          backgroundColor: Colors.blue,
        ));
  }
}
