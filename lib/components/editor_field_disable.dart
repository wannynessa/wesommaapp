import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditorFieldDisable extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icone;
  final bool obscure;

  EditorFieldDisable({this.controller, this.label, this.hint, this.icone, this.obscure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
      child: TextField(
        readOnly: true,
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        textAlign: TextAlign.start,
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
