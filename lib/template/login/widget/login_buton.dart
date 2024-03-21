import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../services/api_log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SubmitButton extends StatelessWidget {
  // final String email;
  // final String password;
  // final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SubmitButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  login(BuildContext context) async {
    var data = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
    };
    if (kDebugMode) {
      print(data);
    }

    var res = await Api().login(data);
    var body = json.decode(res.body);
    if (kDebugMode) {
      print(body);
    }

    if (body['code'] == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Credentials')));
    }

    if (body['token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      if (kDebugMode) {
        print(localStorage.getString('token'));
      }

      Navigator.pushNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Si le formulaire est valide, affichez un message de succès.
          login(context);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Processing Data')),
          // );
        }
      },
      child: const Text('Submit'),
    );
  }
}
