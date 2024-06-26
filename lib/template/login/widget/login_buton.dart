import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SubmitButton extends StatelessWidget {
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

    Api apiInstance = Api();
    var res = await apiInstance.login(data);
    var body = json.decode(res.body);
    if (kDebugMode) {
      print(body);
    }

    if (body['code'] == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Credentials')
        )
      );
    }

    if (body['token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);

      Navigator.pushNamed(context, '/dashboard');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion réussie'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          login(context);
        }
      },
      child: const Text('Submit'),
    );
  }
}
