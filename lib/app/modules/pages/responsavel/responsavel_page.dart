import 'package:acompanhamento_escolar/app/modules/pages/notas/notas_controller.dart';
import 'package:acompanhamento_escolar/app/shared/util/UsuarioFirebase.dart';
import 'package:acompanhamento_escolar/widgets/alertDialog_customizado.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/raised_button_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResponsavelPage extends StatefulWidget {
  @override
  _ResponsavelPageState createState() => _ResponsavelPageState();
}

class _ResponsavelPageState extends State<ResponsavelPage> {
  _deslogarUsuario() async {
    UsuarioFirebase.getDeslogar();
    Modular.to.navigator.pushReplacementNamed("/");
  }

  final bloc = Modular.get<NotasController>();
  @override
  void initState() {
    super.initState();

    bloc.verificarResponsaveldoAluno();
    bloc.adicionarListenerNotas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área do Resposável"),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: _deslogarUsuario,
          ),
        ],
      ),
      body: LayoutBuilderCustomizado(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButtonCustomizado(
                text: "Notas",
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
                shape: 20,
                onPressed: () {
                  Navigator.pushNamed(context, "/NOTAS");
                },
              ),
              RaisedButtonCustomizado(
                text: "Avisos",
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
                shape: 20,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialogCustomizado(),
                  );
                },
              ),
              RaisedButtonCustomizado(
                text: "Frequência",
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 26),
                shape: 20,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialogCustomizado(),
                  );
                },
              ),
              RaisedButtonCustomizado(
                text: "Provas",
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
                shape: 20,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialogCustomizado(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
