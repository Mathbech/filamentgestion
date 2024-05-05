import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
import 'dart:convert';

class ImprimantePage extends StatefulWidget {
  const ImprimantePage({super.key});

  static const String routeName = '/imprimante';

  @override
  ImprimantePageState createState() {
    return ImprimantePageState();
  }
}

class ImprimantePageState extends State<ImprimantePage> {
  List<Imprimante> imprimante = [];
  String contentName = 'Imprimante';
  String details = 'Détails de l\'imprimante';
  @override
  void initState() {
    super.initState();
    getImprimante();
  }

  Future<List<Imprimante>> getImprimante() async {
    Api apiInstance = Api();
    List<dynamic>? tempImprimantes = await apiInstance.imprimante(context);
    if (tempImprimantes != null) {
      imprimante = tempImprimantes.map((imprimante) => Imprimante.fromMap(jsonDecode(imprimante))).toList();
      return imprimante;
    } else {
      if (kDebugMode) {
        print('La méthode impression a retourné null');
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Imprimantes'),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getImprimante();
            });
          },
          child: FutureBuilder<List<Imprimante>>(
            future: getImprimante(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else if (imprimante.isEmpty) {
                return Center(child: Text('Aucunes données disponibles.'));
              } else {
                imprimante = snapshot.data!;
                return ListView.builder(
                  itemCount: imprimante.length,
                  itemBuilder: (context, index) {
                    var imprimantes = imprimante[index];
                    return Card(
                      elevation: 3,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text('${contentName} ${index + 1}'),
                        subtitle: Text(
                            'Nom: ${imprimantes.nom}, Marque: ${imprimantes.marque}'),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailPage(
                          //       item: bobine[index],
                          //       detailTitle: '${details}',
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    );
                  },
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getImprimante();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class Imprimante {
  final String nom;
  final String marque;

  Imprimante({required this.nom, required this.marque});

  factory Imprimante.fromMap(Map<String, dynamic> map) {
    return Imprimante(
      nom: map['nom_imprimante'],
      marque: map['marque'],
    );
  }
}
