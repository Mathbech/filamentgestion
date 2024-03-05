import 'package:flutter/material.dart';
import '/template/index.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },

    );
  }
}
