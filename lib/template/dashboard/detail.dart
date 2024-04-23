import 'dart:convert';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final String detailTitle;

  DetailPage({required String itemString, required String detail}) : item = jsonDecode(itemString), detailTitle = detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${detailTitle}'),
      ),
    //   body: Center(
    //     child: Text('Détails pour ${item['prix']}'), // Remplacez 'name' par la clé appropriée de votre Map
    //   ),
    // );
    body: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text('Clé'),
            ),
            DataColumn(
              label: Text('Valeur'),
            ),
          ],
          rows: item.keys
              .map((key) => DataRow(cells: [
                    DataCell(Text(key)),
                    DataCell(Text(item[key].toString())),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}