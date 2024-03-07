import 'package:flutter/material.dart';
import './login_buton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/';

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _logFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      
      body: Form(
      key: _logFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                // return 'Please enter some text';
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter some text'),
                  ),
                );
              }
              return null;
            },
          ),
          SubmitButtonInputElement(
            email: _emailController.text,
            password: _passwordController.text,
          ),
          

        ],
      ),
    )
    );
  }
}
