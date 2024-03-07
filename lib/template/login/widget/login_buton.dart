import 'package:flutter/material.dart';

class SubmitButtonInputElement extends StatelessWidget {
  final String email;
  final String password;

  const SubmitButtonInputElement({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Utilisez 'email' et 'password' ici
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Processing Data'),
          ),
        );
      },
      child: const Text('Login'),
    );
  }
}