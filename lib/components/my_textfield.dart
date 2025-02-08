import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {

  final controller;
  final String hintText;
  final bool obsecureText;

  const MytextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: 
        TextField(
          controller: controller,
          obscureText: obsecureText,

          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            fillColor: Colors.grey.shade200,
            filled: true,
        ),
      ),
    );
  }
}