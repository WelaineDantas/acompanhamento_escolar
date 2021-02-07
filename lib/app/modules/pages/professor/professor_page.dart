import 'package:acompanhamento_escolar/app/modules/pages/professor/professor_controller.dart';
import 'package:acompanhamento_escolar/widgets/alertDialog_customizado.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/raised_button_customizado.dart';
import 'package:acompanhamento_escolar/widgets/textField_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  final bloc = Modular.get<ProfessorController>();

  @override
  void initState() {
    super.initState();
    bloc.adicionarListenerAlunos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Área do Professor"),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: bloc.deslogarUsuario,
          ),
        ],
      ),
      body: LayoutBuilderCustomizado(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TextCustomizado(
                  text: "Lista de alunos",
                  fontSize: 18,
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.amber,
                      width: 2.5,
                    ),
                  ),
                  height: 180,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: bloc.controllerListaAlunos.stream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return bloc.mensagemCarregando;
                            break;
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text("Erro ao carregar dados!");
                            } else {
                              QuerySnapshot querySnapshot = snapshot.data;
                              if (querySnapshot.docs.length == 0) {
                                return bloc.mensagemSemDados;
                              } else {
                                return ListView.separated(
                                  itemCount: querySnapshot.docs.length,
                                  separatorBuilder: (context, indice) =>
                                      Divider(
                                    height: 2,
                                    color: Colors.amber,
                                  ),
                                  itemBuilder: (context, indice) {
                                    List<DocumentSnapshot> alunos =
                                        querySnapshot.docs.toList();
                                    DocumentSnapshot item = alunos[indice];

                                    String id = item["idAluno"];
                                    String nomeAluno = item["nomeAluno"];

                                    return ListTile(
                                      title: Text(nomeAluno),
                                      selected:
                                          nomeAluno == bloc.alunoSelecionado,
                                      onTap: () {
                                        bloc.idAluno = id;
                                        bloc.recuperarAlunoSelecionado(
                                            bloc.idAluno);
                                        setState(() {
                                          bloc.alunoSelecionado = nomeAluno;
                                        });
                                      },
                                    );
                                  },
                                );
                              }
                            }
                            break;
                        }
                      }),
                ),
                SizedBox(height: 15),
                TextCustomizado(
                  text: "Aluno selecionado: ${bloc.alunoSelecionado}",
                  fontSize: 16,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: RaisedButtonCustomizado(
                              text: "Notas",
                              shape: 10,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                        "Adicionar Nota do aluno: ${bloc.alunoSelecionado}"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFieldCustomizado(
                                          controller: bloc.controllerNota,
                                          labelText: "Nota",
                                        ),
                                        Divider(color: Color(0)),
                                        TextFieldCustomizado(
                                          controller: bloc.controllerMateria,
                                          labelText: "Materia",
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text("Salvar"),
                                        onPressed: () {
                                          bloc.salvarNota(
                                            bloc.controllerNota.text,
                                            bloc.controllerMateria.text,
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
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: RaisedButtonCustomizado(
                              text: "Avisos",
                              shape: 10,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialogCustomizado(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButtonCustomizado(
                              text: "Frequência",
                              shape: 10,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialogCustomizado(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: RaisedButtonCustomizado(
                              text: "Provas",
                              shape: 10,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialogCustomizado(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
