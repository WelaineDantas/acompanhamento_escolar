import 'package:flutter/material.dart';

class IconCustomizado extends StatelessWidget {
  final IconData icon;

  IconCustomizado({
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
      size: 30,
    );
  }
}
