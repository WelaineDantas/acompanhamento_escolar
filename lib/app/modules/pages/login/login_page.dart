import 'package:acompanhamento_escolar/app/modules/pages/login/login_controller.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/raised_button_customizado.dart';
import 'package:acompanhamento_escolar/widgets/textField_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colégio Meireles"),
      ),
      body: LayoutBuilderCustomizado(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Image.asset(
              "assets/icone_principal.png",
              height: 130,
            ),
            // GestureDetector(
            //   onTap: () => null,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
            //     color: Color(0xff4285f4),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         TextCustomizado(
            //           text: "Entrar com o Google",
            //           color: Colors.white,
            //           fontSize: 18,
            //         ),
            //         Container(
            //           color: Colors.white,
            //           padding: EdgeInsets.all(5),
            //           child: Image.asset(
            //             "assets/google.png",
            //             height: 30,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            TextCustomizado(
              text: "Ou entre com seu e-mail:",
              textAlign: TextAlign.start,
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
              text: "Entrar",
              onPressed: () {
                bloc.validarCampos();
              },
              shape: 100,
            ),
            GestureDetector(
              child: TextCustomizado(
                text: "Esqueceu a Senha? Clique aqui!",
                color: Colors.grey[700],
                fontSize: 15,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Recuperar senha"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldCustomizado(
                          controller: bloc.controllerEmail,
                          labelText: "Email",
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Enviar email"),
                        onPressed: () {
                          bloc.recuperarSenha();
                        },
                      ),
                      FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            Modular.to.navigator.pop();
                          }),
                    ],
                  ),
                );
              },
            ),
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
                      color: Colors.red,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
