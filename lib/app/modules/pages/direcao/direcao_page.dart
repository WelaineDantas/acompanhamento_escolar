import 'package:acompanhamento_escolar/app/modules/pages/direcao/direcao_controller.dart';
import 'package:acompanhamento_escolar/widgets/button_customizado.dart';
import 'package:acompanhamento_escolar/widgets/icon_customizado.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/textField_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DirecaoPage extends StatefulWidget {
  @override
  _DirecaoPageState createState() => _DirecaoPageState();
}

class _DirecaoPageState extends State<DirecaoPage> {
  final bloc = Modular.get<DirecaoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área da Direção"),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: bloc.deslogarUsuario,
          ),
        ],
      ),
      body: LayoutBuilderCustomizado(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonCustomizado(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextCustomizado(
                    text: "Cadastrar Aluno",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  IconCustomizado(
                    icon: Icons.account_box_rounded,
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Cadastrar aluno"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldCustomizado(
                          controller: bloc.controllerAluno,
                          labelText: "Nome completo",
                        ),
                        Divider(color: Color(0)),
                        TextFieldCustomizado(
                          controller: bloc.controllerNomeResponsavel,
                          labelText: "Nome do Responsável",
                        ),
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
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Adicionar"),
                        onPressed: () {
                          bloc.cadastrarAluno(
                            bloc.controllerAluno.text,
                            bloc.controllerNomeResponsavel.text,
                          );
                        },
                      ),
                      FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            bloc.limparCampos();
                            Modular.to.navigator.pop();
                          }),
                    ],
                  ),
                );
              },
            ),
            Divider(),
            TextCustomizado(
              text:
                  "Dê permisão para Responsavéis e Professores terem acesso ao App apenas informando o email deste.",
              fontSize: 20,
            ),
            Divider(),
            ButtonCustomizado(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextCustomizado(
                    text: "Adicionar Responsável",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  IconCustomizado(
                    icon: Icons.family_restroom,
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Email do responsável"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldCustomizado(
                          controller: bloc.controllerNomeResponsavel,
                          labelText: "Nome",
                        ),
                        Divider(color: Color(0)),
                        TextFieldCustomizado(
                          controller: bloc.controllerEmailResponsavel,
                          labelText: "Email",
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Adicionar"),
                        onPressed: () {
                          bloc.adicionarResponsavel(
                            bloc.controllerNomeResponsavel.text,
                            bloc.controllerEmailResponsavel.text,
                          );
                        },
                      ),
                      FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            bloc.limparCampos();
                            Modular.to.navigator.pop();
                          }),
                    ],
                  ),
                );
              },
            ),
            ButtonCustomizado(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextCustomizado(
                    text: "Adicionar Professor",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Adicionar professor"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldCustomizado(
                          controller: bloc.controllerEmailProfessor,
                          labelText: "Email",
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Adicionar"),
                        onPressed: () {
                          bloc.adicionarProfessor(
                            bloc.controllerEmailProfessor.text,
                          );
                        },
                      ),
                      FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            bloc.limparCampos();
                            Modular.to.navigator.pop();
                          }),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
