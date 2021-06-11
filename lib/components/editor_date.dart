import 'package:flutter/material.dart';

class EditorDate extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  EditorDate({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
          icon: icone != null ? Icon(icone) : null,
        ),
        keyboardType: TextInputType.datetime,
      ),
    );
  }
}
