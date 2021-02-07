import 'package:flutter/material.dart';

class RaisedButtonCustomizado extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color colorText;
  final Color colorButton;
  final EdgeInsetsGeometry padding;
  final double shape;
  final double fontSize;

  RaisedButtonCustomizado({
    this.text,
    this.onPressed,
    this.colorText,
    this.colorButton,
    this.padding,
    this.shape,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 20,
          color: colorText ?? Colors.white,
        ),
      ),
      color: colorButton ?? Colors.amber[600],
      padding: padding ?? EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(shape)),
      onPressed: onPressed,
    );
  }
}
