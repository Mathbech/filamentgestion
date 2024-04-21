import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';

class ImpressionsPage extends StatefulWidget {
  const ImpressionsPage({super.key});
  static const String routeName = '/impressions';

  @override
  ImpressionsPageState createState() {
    return ImpressionsPageState();
  }
}

class ImpressionsPageState extends State<ImpressionsPage> {
  List<String> impressions = [];

  @override
  void initState() {
    super.initState();
    getImpressions();
  }

  Future<void> getImpressions() async {
    Api apiInstance = Api();
    List<dynamic>? tempImpressions = await apiInstance.impressions(context);
    if (tempImpressions != null) {
      impressions =
          tempImpressions.map((impression) => impression.toString()).toList();
      print(impressions);
    } else {
      if (kDebugMode) {
        print('La méthode impressions a retourné null');
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Impressions'),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: getImpressions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            if (impressions.isEmpty) {
              return Center(child: Text('Aucune données disponible'));
            } else {
              return ListView.builder(
                itemCount: impressions.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 3,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text('Impression ${index + 1}'),
                        subtitle: Text('Référence: ${impressions[index]}'),
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
