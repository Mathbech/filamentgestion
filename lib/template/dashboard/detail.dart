import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {
  final String item;

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails'),
      ),
      body: Center(
        child: Text('Détails pour $item'),
      ),
    );
  }
}