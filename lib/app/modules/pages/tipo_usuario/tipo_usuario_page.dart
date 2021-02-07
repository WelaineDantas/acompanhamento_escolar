import 'package:acompanhamento_escolar/widgets/raised_button_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TipoUsuarioPage extends StatefulWidget {
  @override
  _TipoUsuarioPageState createState() => _TipoUsuarioPageState();
}

class _TipoUsuarioPageState extends State<TipoUsuarioPage> {
  String usuario = "";

  void Salvar() {
    String tipoUsuario;

    setState(() {
      tipoUsuario = usuario;
    });
    Modular.to.pushNamed("/CADASTRO/${tipoUsuario}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          "Colégio Meireles",
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80, bottom: 80, left: 40, right: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextCustomizado(
              text: "Quem é você?",
              fontSize: 35,
              color: Colors.white,
            ),
            RaisedButtonCustomizado(
              text: "Responsável",
              colorText: Colors.amber,
              colorButton: Colors.white,
              shape: 100,
              onPressed: () {
                usuario = "Responsavel";
                Salvar();
              },
            ),
            RaisedButtonCustomizado(
              text: "Professor",
              colorText: Colors.amber,
              colorButton: Colors.white,
              shape: 100,
              onPressed: () {
                usuario = "Professor";
                Salvar();
              },
            ),
            RaisedButtonCustomizado(
              text: "Direção",
              colorText: Colors.amber,
              colorButton: Colors.white,
              shape: 100,
              onPressed: () {
                usuario = "Direcao";
                Salvar();
              },
            ),
          ],
        ),
      ),
    );
  }
}
