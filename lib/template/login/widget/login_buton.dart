import 'package:flutter/material.dart';

// class SubmitButtonInputElement extends StatelessWidget {
//   final String email;
//   final String password;

//   const SubmitButtonInputElement(
//       {super.key, required this.email, required this.password});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         if (_logFormKey.currentState!.validate()) {
//           // Si le formulaire est valide, affichez un message de succès.
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Processing Data')),
//           );
//         }
//       },
//       child: const Text('Submit'),
//     );
//   }
// }


class SubmitButtonInputElement extends StatelessWidget {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;

  const SubmitButtonInputElement({
    Key? key,
    required this.email,
    required this.password,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Si le formulaire est valide, affichez un message de succès.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
        }
      },
      child: const Text('Submit'),
    );
  }
}