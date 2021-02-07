import 'package:flutter/material.dart';

class TextCustomizado extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color color;

  TextCustomizado({
    this.text,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 16,
        color: color ?? Colors.black,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
