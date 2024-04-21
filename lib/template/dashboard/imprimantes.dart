import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';

class ImprimantePage extends StatefulWidget {
  const ImprimantePage({super.key});

  static const String routeName = '/imprimante';

  @override
  ImprimantePageState createState() {
    return ImprimantePageState();
  }
}

class ImprimantePageState extends State<ImprimantePage> {
  List<String> imprimante = [];
  @override
  void initState() {
    super.initState();
    getImprimante();
  }

  Future<void> getImprimante() async {
    Api apiInstance = Api();
    List<dynamic>? tempimprimante = await apiInstance.imprimante(context);
    if (tempimprimante != null) {
      imprimante = tempimprimante.map((vente) => vente.toString()).toList();
      print(imprimante);
    } else {
      if (kDebugMode) {
        print('La méthode Imprimante a retourné null');
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Imprimantes'),
      drawer: CustomDrawer(),


      body: FutureBuilder(
        future: getImprimante(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: imprimante.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child:  ListTile(
                  title: Text('Vente ${index + 1}'),
                  subtitle: Text('Référence: ${imprimante[index]}'),
                  onTap: () {
                  },
                  )
                );
              },
            );
          }
        },
      ),
    );
  }
}
