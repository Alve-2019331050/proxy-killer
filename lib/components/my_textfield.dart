import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{

  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 10.0),
      child: TextField(
        controller: controller,
        obscureText : obscureText,
        decoration: InputDecoration(
          enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}