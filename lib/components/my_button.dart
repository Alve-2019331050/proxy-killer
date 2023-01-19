import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()?onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 75),
            decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )));
  }
}
