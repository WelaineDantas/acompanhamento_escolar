import 'package:flutter/material.dart';

class ButtonCustomizado extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  ButtonCustomizado({
    this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.amber[600],
      padding: EdgeInsets.symmetric(vertical: 20),
      onPressed: onPressed,
    );
  }
}
