import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditorText extends StatelessWidget {
  final String rotulo;
  final String dica;
  final IconData icone;
  double fontSize = 24.0;

  EditorText({this.rotulo, this.dica, this.icone, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        rotulo,
        style: TextStyle(
          fontSize: fontSize,
        ), textWidthBasis: TextWidthBasis.longestLine,
        textAlign: TextAlign.left,
      ),
    );
  }
}
