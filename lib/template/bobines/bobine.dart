import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
// import '../dashboard/detail.dart';
import 'dart:convert';

class BobinePage extends StatefulWidget {
  const BobinePage({super.key});

  static const String routeName = '/bobine';

  @override
  BobinePageState createState() {
    return BobinePageState();
  }
}

class BobinePageState extends State<BobinePage> {
  List<Bobine> bobine = [];
  String contentName = 'Bobine';
  String details = 'Détails de la bobine';
  @override
  void initState() {
    super.initState();
    getBobines();
  }

Future<List<Bobine>> getBobines() async {
  Api apiInstance = Api();
  List<dynamic>? tempBobines = await apiInstance.bobine(context);
  if (tempBobines != null) {
    bobine = tempBobines.map((bobine) => Bobine.fromMap(jsonDecode(bobine))).toList();
    return bobine;
  } else {
    if (kDebugMode) {
      print('La méthode bobine a retourné null');
    }
    return [];
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Stocks'),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getBobines();
          });
        },
        child: FutureBuilder<List<Bobine>>(
            future: getBobines(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else {
                bobine = snapshot.data!;
                return ListView.builder(
                  itemCount: bobine.length,
                  itemBuilder: (context, index) {
                    var bobines = bobine[index];
                    return Card(
                      elevation: 3,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text('${contentName} ${index + 1}'),
                        subtitle: Text(
                            'Couleur: ${bobines.couleur}, Catégorie de filament: ${bobines.categorie}'),
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
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getBobines();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class Bobine {
  final String couleur;
  final String categorie;

  Bobine({required this.couleur, required this.categorie});

  // Convertir un Map en une instance de Bobine
  factory Bobine.fromMap(Map<String, dynamic> map) {
    return Bobine(
      couleur: map['couleur'],
      categorie: map['categorie'],
    );
  }
}
