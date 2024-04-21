// lib/custom_list_view.dart

import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<String> items;
  final String emptyMessage;
  final String contentName;

  CustomListView({required this.items, required this.emptyMessage, required this.contentName});

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
                // action à mettre plus tard
              },
            ),
          );
        },
      );
    }
  }
}
