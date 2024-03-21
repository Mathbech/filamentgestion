import 'package:flutter/material.dart';
import '../../../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SubmitButtonInputElement extends StatelessWidget {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;

  const SubmitButtonInputElement({
    super.key,
    required this.email,
    required this.password,
    required this.formKey,
  });

  login(BuildContext context) async {
    var data = {
      'email': email,
      'password': password,
    };

    var res = await Api().login(data);
    print(res.body);
    var body = json.decode(res.body);

    if (body['code'] == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Credentials')));
    }

    if (body['token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);

      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Si le formulaire est valide, affichez un message de succès.
          login(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
        }
      },
      child: const Text('Submit'),
    );
  }
}
