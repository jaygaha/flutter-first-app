import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      // color: Theme.of(context).primaryColor,
      color: const Color.fromRGBO(44, 166, 164, 1),
      textColor: Colors.black,
      child: Text(text),
    );
  }
}
