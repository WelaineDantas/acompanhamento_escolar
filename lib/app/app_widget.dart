import 'package:acompanhamento_escolar/app/modules/pages/home/home_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Colégio Meireles',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: "/",
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
