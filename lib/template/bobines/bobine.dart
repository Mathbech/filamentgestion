import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';
import '../dashboard/detail.dart';

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
  String contentName = 'Bobine';
  String details = 'Détails de la bobine';
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(title: 'Stocks'),
  //     drawer: CustomDrawer(),
  //     body: FutureBuilder(
  //       future: getBobines(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Text('Erreur: ${snapshot.error}');
  //         } else {
  //           return ListView.builder(
  //             itemCount: bobines.length,
  //             itemBuilder: (context, index) {
  //               return Card(
  //                 elevation: 3,
  //                 margin:
  //                     EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  //                 child: ListTile(
  //                   title: Text('${contentName} ${index + 1}'),
  //                   subtitle: Text('Référence: ${bobines[index]}'),
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => DetailPage( itemString: bobines[index], detail: '${details}'),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               );
  //             },
  //           );
  //         }
  //       }
  //     ),
  //   );
  // }
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
        child: FutureBuilder(
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
                  return Card(
                    elevation: 3,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text('${contentName} ${index + 1}'),
                      subtitle: Text('Référence: ${bobines[index]}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                itemString: bobines[index],
                                detail: '${details}'),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
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
