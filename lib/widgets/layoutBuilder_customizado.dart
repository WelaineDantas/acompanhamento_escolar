import 'package:flutter/material.dart';

class LayoutBuilderCustomizado extends StatelessWidget {
  final Widget child;

  LayoutBuilderCustomizado({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/plano_fundo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          ),
        ),
      );
    });
  }
}
