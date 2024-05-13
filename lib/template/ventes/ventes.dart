import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
import '../dashboard/detail.dart';

class VentePage extends StatefulWidget {
  const VentePage({super.key});

  static const String routeName = '/ventes';

  @override
  VentePageState createState() {
    return VentePageState();
  }
}

class VentePageState extends State<VentePage> {
  List<Vente> ventes = [];
  String contentName = 'Vente';
  String details = 'Détails de la vente';
  @override
  void initState() {
    super.initState();
    getVentes();
  }
  Future<List<Vente>> getVentes() async {
    Api apiInstance = Api();
    List<dynamic>? tempVentes = await apiInstance.vente(context);
    if (tempVentes != null) {
      ventes = tempVentes.map((vente) => Vente.fromMap(jsonDecode(vente))).toList();
      return ventes;
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
      appBar: CustomAppBar(title: 'Ventes'),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getVentes();
            });
          },
          child: FutureBuilder<List<Vente>>(
            future: getVentes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else if (ventes.isEmpty) {
                return Center(child: Text('Aucunes données disponibles.'));
              } else {
                ventes = snapshot.data!;
                return ListView.builder(
                  itemCount: ventes.length,
                  itemBuilder: (context, index) {
                    var vente = ventes[index];
                    return Card(
                      elevation: 3,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text('${contentName} ${index + 1}'),
                        subtitle: Text(
                            'Nom du produit : ${vente.nom}, Prix de vente: ${vente.prix}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                item: vente.toMap(),
                                detailTitle: '${details}',
                              ),
                            ),
                          );
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
            getVentes();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class Vente {
  final String nom;
  final double prix;
  final String date;
  final String description;


  Vente({
    required this.nom,
    required this.prix,
    required this.date,
    required this.description,
  });

  factory Vente.fromMap(Map<String, dynamic> map) {
    return Vente(
      nom: map['nom_produit'],
      prix: map['prix_produit'],
      date: DateFormat('dd/MM/yyyy').format(DateTime.parse(map['date_vente']),),
      description: map['description_produit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom du produit': nom,
      'prix du produit': prix,
      'date de la vente': date,
      'description du produit': description,

    };
  }
}
