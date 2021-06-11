import 'package:flutter/material.dart';

class EditorNumberDisable extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icone;

  EditorNumberDisable({this.controller, this.label, this.hint, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        readOnly: true,
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: icone != null ? Icon(icone) : null,
        ),
        keyboardType: TextInputType.numberWithOptions(),
      ),
    );
  }
}
