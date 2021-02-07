import 'package:acompanhamento_escolar/app/modules/pages/notas/notas_controller.dart';
import 'package:acompanhamento_escolar/widgets/layoutBuilder_customizado.dart';
import 'package:acompanhamento_escolar/widgets/text_customizado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotasPage extends StatefulWidget {
  @override
  _NotasPageState createState() => _NotasPageState();
}

class _NotasPageState extends State<NotasPage> {
  NotasController bloc = Modular.get<NotasController>();

  String usuarioLogado;
  String aluno = "---";

  var mensagemCarregando = Center(
    child: Column(
      children: [
        Text("Carregando lista de notas"),
        CircularProgressIndicator()
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    print("usuaario: $usuarioLogado");

    return Scaffold(
      appBar: AppBar(
        title: Text("Notas"),
      ),
      body: LayoutBuilderCustomizado(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: StreamBuilder(
                  stream: bloc.outputAluno,
                  builder: (context, snapshot) {
                    return TextCustomizado(
                      text: "Aluno: \" ${snapshot.data} \"",
                      textAlign: TextAlign.start,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.amber,
                      width: 3,
                    )),
                //color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: bloc.controller.stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return mensagemCarregando;
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
                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, indice) {
                                print("usuario atual" + usuarioLogado);
                                List<DocumentSnapshot> notas =
                                    querySnapshot.docs.toList();
                                DocumentSnapshot item = notas[indice];
                                print(usuarioLogado);

                                if (item["aluno"]["nomeResponsavel"] !=
                                    usuarioLogado) {
                                  return SizedBox(height: 0);
                                } else {
                                  print(item["materia"]);

                                  bloc.nomeAluno = item["aluno"]["nomeAluno"];
                                  bloc.materia = item["materia"];
                                  bloc.nota = item["nota"];
                                  bloc.inputAluno.add(bloc.nomeAluno);
                                  print("aluno: " + bloc.nomeAluno);

                                  return ListTile(
                                    isThreeLine: true,
                                    title: TextCustomizado(
                                      text: "Matéria: ${bloc.materia}",
                                      textAlign: TextAlign.left,
                                    ),
                                    subtitle: Text(
                                      "Nota: ${bloc.nota}",
                                      style: TextStyle(
                                        color: Colors.amber[600],
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }

                        break;
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: StreamBuilder<String>(
                  stream: bloc.controllerUsuarioAtual.stream,
                  initialData: bloc.usuarioAtual,
                  builder: (context, snapshot) {
                    usuarioLogado = snapshot.data;
                    return TextCustomizado(
                      text: "Responsavel:  \" ${snapshot.data} \" ",
                      textAlign: TextAlign.start,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
