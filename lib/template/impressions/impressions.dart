import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
import '../dashboard/detail.dart';

class ImpressionsPage extends StatefulWidget {
  const ImpressionsPage({super.key});
  static const String routeName = '/impressions';

  @override
  ImpressionsPageState createState() {
    return ImpressionsPageState();
  }
}

class ImpressionsPageState extends State<ImpressionsPage> {
  List<Impression> impression = [];
  String contentName = 'Impression';
  String details = 'Détails des impresssions';

  @override
  void initState() {
    super.initState();
    getImpressions();
  }

  Future<List<Impression>> getImpressions() async {
    Api apiInstance = Api();
    List<dynamic>? tempImpressions = await apiInstance.impressions(context);
    if (tempImpressions != null) {
      impression = tempImpressions
          .map((impression) => Impression.fromMap(jsonDecode(impression)))
          .toList();
      return impression;
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
      appBar: CustomAppBar(title: 'Impressions'),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getImpressions();
            });
          },
          child: FutureBuilder<List<Impression>>(
            future: getImpressions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else if (impression.isEmpty) {
                return Center(child: Text('Aucunes données disponibles.'));
              } else {
                impression = snapshot.data!;
                return ListView.builder(
                  itemCount: impression.length,
                  itemBuilder: (context, index) {
                    var impressions = impression[index];
                    return Card(
                      elevation: 3,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text('${contentName} ${index + 1}'),
                        subtitle: Text(
                            'Poids de bobine consommé: ${impressions.poids}, Date d\'impression: ${impressions.date_impression}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                item: impressions.toMap(),
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
            getImpressions();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class Impression {
  final double poids;
  final String date_impression;
  final String temps;

  Impression({required this.poids, required this.date_impression, required this.temps});

  factory Impression.fromMap(Map<String, dynamic> map) {
    return Impression(
      poids: map['poids'],
      date_impression: DateFormat('dd/MM/yyyy').format(DateTime.parse(map['date']),),
      temps: DateFormat('HH:mm').format(DateTime.parse(map['temps'])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'poids': poids,
      'date_impression': date_impression,
      'temps': temps,
    };
  }
}
