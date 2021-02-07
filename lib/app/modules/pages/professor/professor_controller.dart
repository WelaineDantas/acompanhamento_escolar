import 'dart:async';
import 'package:acompanhamento_escolar/app/shared/model/Aluno.dart';
import 'package:acompanhamento_escolar/app/shared/model/Nota.dart';
import 'package:acompanhamento_escolar/app/shared/util/UsuarioFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class ProfessorController {
  BehaviorSubject _streamController = BehaviorSubject();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  var controllerNota = TextEditingController();
  var controllerMateria = TextEditingController();

  String alunoSelecionado = "";
  String idAluno = "";

  final controllerListaAlunos = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore db = FirebaseFirestore.instance;

  deslogarUsuario() async {
    UsuarioFirebase.getDeslogar();
    Modular.to.navigator.pushReplacementNamed("/");
  }

  Future<Aluno> recuperarAlunoSelecionado(String id) async {
    DocumentSnapshot snapshot = await db.collection("alunos").doc(id).get();

    Map<String, dynamic> dados = snapshot.data();
    String idAluno = dados["idAluno"];
    String nomeAluno = dados["nomeAluno"];
    String nomeResponsavel = dados["nomeResponsavel"];

    Aluno aluno = Aluno();
    aluno.idAluno = idAluno;
    aluno.nomeAluno = nomeAluno;
    aluno.nomeResponsavel = nomeResponsavel;

    return aluno;
  }

  salvarNota(String nota, String materia) async {
    Aluno aluno = await recuperarAlunoSelecionado(idAluno);

    Nota notaAluno = Nota();
    notaAluno.nota = nota;
    notaAluno.materia = materia;
    notaAluno.aluno = aluno;

    db.collection("notas").add(notaAluno.toMap());
    limparCampos();
  }

  Stream<QuerySnapshot> adicionarListenerAlunos() {
    final stream = db.collection("alunos").snapshots();

    stream.listen((dados) {
      controllerListaAlunos.add(dados);
    });
  }

  var mensagemCarregando = Center(
    child: Column(
      children: [
        Text("Carregando lista de alunos"),
        CircularProgressIndicator()
      ],
    ),
  );

  var mensagemSemDados = Center(
    child: Text("Não tem alunos cadastrados"),
  );

  limparCampos() {
    controllerNota.clear();
    controllerMateria.clear();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
