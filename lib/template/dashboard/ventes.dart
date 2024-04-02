import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';

class VentePage extends StatefulWidget {
  const VentePage({super.key});

  static const String routeName = '/bobine';

  @override
  VentePageState createState() {
    return VentePageState();
  }
}

class VentePageState extends State<VentePage> {
  List<String> ventes = [];
  @override
  void initState() {
    super.initState();
    getVentes();
  }

  Future<void> getVentes() async {
    Api apiInstance = Api();
    List<dynamic>? tempVentes = await apiInstance.vente(context);
    if (tempVentes != null) {
      ventes = tempVentes.map((vente) => vente.toString()).toList();
      print(ventes);
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
        title: const Text('Liste des Ventes'),
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
      body: FutureBuilder(
        future: getVentes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: ventes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Vente ${index + 1}'),
                  subtitle: Text('Référence: ${ventes[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
