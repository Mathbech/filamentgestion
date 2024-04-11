import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../widget/appbar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Stocks'),
      drawer: CustomDrawer(),


      body: FutureBuilder(
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
                return ListTile(
                  title: Text('Bobine ${index + 1}'),
                  subtitle: Text('Référence: ${bobines[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
