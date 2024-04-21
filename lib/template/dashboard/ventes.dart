import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';

class VentePage extends StatefulWidget {
  const VentePage({super.key});

  static const String routeName = '/ventes';

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
      appBar: CustomAppBar(title: 'Ventes'),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: getVentes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            if (ventes.isEmpty) {
              return Center(child: Text('Aucune données disponible'));
            } else {
              return ListView.builder(
                itemCount: ventes.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 3,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text('Vente ${index + 1}'),
                        subtitle: Text('Référence: ${ventes[index]}'),
                        onTap: () {
                          // action à mettre plus tard
                        },
                      ));
                },
              );
            }
          }
        },
      ),
    );
  }
}
