import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditorField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icone;
  final bool obscure;

  EditorField({this.controller, this.label, this.hint, this.icone, this.obscure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: icone != null ? Icon(icone) : null,
        ),
        keyboardType: TextInputType.text,
        obscureText: obscure != null ? obscure : false,
      ),
    );
  }
}
