import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/home';

  @override
  DashboardPageState createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Homepage'),
        ),
        body: const Center(
          child: Text('Welcome to the homepage'),
        ));
  }
}
