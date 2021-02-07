import 'package:acompanhamento_escolar/app/modules/pages/home/home_controller.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/raised_button_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    bloc.verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colégio Meireles"),
      ),
      body: LayoutBuilderCustomizado(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/icone_principal.png",
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  TextCustomizado(
                    text: "Seja bem-vindo(a)!",
                    fontSize: 30,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButtonCustomizado(
                    text: "Entrar",
                    onPressed: () {
                      Modular.to.navigator.pushNamed("/LOGIN");
                    },
                    shape: 100,
                  ),
                  SizedBox(height: 20),
                  RaisedButtonCustomizado(
                    text: "Cadastrar",
                    onPressed: () {
                      Modular.to.navigator.pushNamed("/TIPOUSUARIO");
                    },
                    shape: 100,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
