import 'package:flutter/material.dart';

class SubmitButtonInputElement extends StatelessWidget { 
  // Si possible, déclarez le constructeur comme const
  const SubmitButtonInputElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implémentez la méthode build
    return ElevatedButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/home');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Processing Data'),
          ),
        );
      },
      child: const Text('Submit'),
    );
  }
}