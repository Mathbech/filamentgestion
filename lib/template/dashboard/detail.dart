import 'dart:convert';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  DetailPage({required String itemString}) : item = jsonDecode(itemString);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails'),
      ),
      body: Center(
        child: Text('Détails pour ${item['prix']}'), // Remplacez 'name' par la clé appropriée de votre Map
      ),
    );
  }
}