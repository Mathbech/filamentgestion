import 'package:flutter/material.dart';
import './login_buton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Bloque le bouton de retour
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Filament Gestion'),
          automaticallyImplyLeading: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintStyle: TextStyle(
                      color: Colors.red, fontSize: 20), // Ajoutez cette ligne
                ),
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              SubmitButtonInputElement(),
            ],
          ),
        ),
      ),
    );
  }
}
