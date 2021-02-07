import 'package:flutter/material.dart';

class TextFieldCustomizado extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final bool enabled;

  TextFieldCustomizado({
    this.controller,
    this.labelText,
    this.obscureText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled ?? true,
      controller: controller,
      obscureText: obscureText ?? false,
      style: TextStyle(
        fontSize: 20,
        backgroundColor: Colors.white,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
