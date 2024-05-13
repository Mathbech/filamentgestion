import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final String detailTitle;
  DetailPage({required this.item, required this.detailTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${detailTitle}'),
      ),
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
                    DataCell(
                      Container(
                        width: 100, // Ajustez cette valeur en fonction de vos besoins
                        child: AutoSizeText(key),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 100, // Ajustez cette valeur en fonction de vos besoins
                        child: AutoSizeText(item[key].toString()),
                      ),
                    ),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
