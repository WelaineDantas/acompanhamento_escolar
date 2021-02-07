import 'package:acompanhamento_escolar/app/modules/pages/cadastro/cadastro_controller.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/raised_button_customizado.dart';
import 'package:acompanhamento_escolar/widgets/textField_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroPage extends StatefulWidget {
  final String tipoUsuario;
  CadastroPage({this.tipoUsuario});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final bloc = Modular.get<CadastroController>();

  @override
  Widget build(BuildContext context) {
    String tipoUsuario = widget.tipoUsuario;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar"),
      ),
      body: LayoutBuilderCustomizado(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldCustomizado(
              controller: bloc.controllerNome,
              labelText: "Nome completo",
            ),
            TextFieldCustomizado(
              controller: bloc.controllerEmail,
              labelText: "Email",
            ),
            TextFieldCustomizado(
              controller: bloc.controllerSenha,
              obscureText: true,
              labelText: "Senha",
            ),
            RaisedButtonCustomizado(
                text: "Cadastrar",
                shape: 100,
                onPressed: () {
                  bloc.validarCampos(tipoUsuario);
                }),
            bloc.carregando
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            Center(
              child: StreamBuilder(
                  stream: bloc.output,
                  initialData: bloc.mensagemErro,
                  builder: (context, snapshot) {
                    return TextCustomizado(
                      text: snapshot.data,
                    );
                  }),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
