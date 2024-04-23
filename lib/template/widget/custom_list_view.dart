import 'package:flutter/material.dart';
import '../dashboard/detail.dart';

class CustomListView extends StatelessWidget {
  final List<String> items;
  final String emptyMessage = 'Aucun élément trouvé';
  final String contentName;
  final String details;

  CustomListView(
      {required this.items,
      required this.contentName,
      required this.details});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(emptyMessage));
    } else {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text('${contentName} ${index + 1}'),
              subtitle: Text('Référence: ${items[index]}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                        itemString: items[index],
                        detail: '${details}'),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }
}
