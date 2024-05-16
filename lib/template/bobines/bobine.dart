import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
import '../dashboard/detail.dart';
import '../../services/data_loader.dart';

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
  DataLoader dataLoader = DataLoader();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await dataLoader.fetchAndStoreData();
    setState(() {
      getBobines();
    });
  }

  Future<List<Bobine>> getBobines() async {
    Api apiInstance = Api();
    List<dynamic>? tempBobines = await apiInstance.bobine(context);
    if (tempBobines != null) {
      bobine = tempBobines
          .map((bobine) => Bobine.fromMap(jsonDecode(bobine)))
          .toList();
      return bobine;
    } else {
      if (kDebugMode) {
        print('La méthode bobine a retourné null');
      }
      return [];
    }
  }

  Future<String?> getColorName(String colorUrl) async {
    final colorsList = await dataLoader.getStoredColors();
    final colorId = colorUrl.split('/').last;

    for (var color in colorsList) {
      if (color['id'].toString() == colorId) {
        return color['nom'];
      }
    }
    return 'Couleur inconnue';
  }

  Future<String?> getCategoryName(String categoryUrl) async {
    final categoriesList = await dataLoader.getStoredCategories();
    final categoryId = categoryUrl.split('/').last;

    for (var category in categoriesList) {
      if (category['id'].toString() == categoryId) {
        return category['nom_type'];
      }
    }
    return 'Catégorie inconnue';
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
              } else if (bobine.isEmpty) {
                return Center(child: Text('Aucunes données disponibles.'));
              } else {
                bobine = snapshot.data!;
                return ListView.builder(
                  itemCount: bobine.length,
                  itemBuilder: (context, index) {
                    var bobines = bobine[index];
                    return FutureBuilder<List<String?>>(
                      future: Future.wait([
                        getColorName(bobines.couleur),
                        getCategoryName(bobines.categorie),
                      ]),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (asyncSnapshot.hasError) {
                          return Text('Erreur: ${asyncSnapshot.error}');
                        } else {
                          var colorName = asyncSnapshot.data?[0] ?? 'Couleur inconnue';
                          var categoryName = asyncSnapshot.data?[1] ?? 'Catégorie inconnue';
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              title: Text('${contentName} ${index + 1}'),
                              subtitle: Text('Couleur: $colorName, Catégorie de filament: $categoryName'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      item: bobines.toMap(),
                                      detailTitle: '${details}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
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
  final String couleur; // URL of the color
  final String categorie; // URL of the category
  final String dateAjout;
  final double poids;
  final double prix;

  Bobine({
    required this.couleur,
    required this.categorie,
    required this.dateAjout,
    required this.poids,
    required this.prix,
  });

  factory Bobine.fromMap(Map<String, dynamic> map) {
    return Bobine(
      couleur: map['couleur'],
      categorie: map['categorie'],
      dateAjout: DateFormat('dd/MM/yyyy').format(DateTime.parse(map['date_ajout'])),
      poids: map['poids'],
      prix: map['prix'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'couleur': couleur,
      'categorie': categorie,
      'date_ajout': dateAjout,
      'poids': poids,
      'prix': prix,
    };
  }
}
