import 'package:flutter/material.dart';

class AlertDialogCustomizado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Não finalizado"),
      actions: [
        FlatButton(
            child: Text("Sair"),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
      elevation: 20.0,
    );
  }
}
