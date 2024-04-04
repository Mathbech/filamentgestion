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
        title: const Text('Liste de bobines'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        // méthode de logout
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: const Icon(Icons.sell_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/ventes');
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
      body: FutureBuilder(
        future: getBobines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: bobines.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Bobine ${index + 1}'),
                  subtitle: Text('Référence: ${bobines[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
