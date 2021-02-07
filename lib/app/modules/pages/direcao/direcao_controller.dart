import 'package:acompanhamento_escolar/app/shared/model/Aluno.dart';
import 'package:acompanhamento_escolar/app/shared/model/Professor.dart';
import 'package:acompanhamento_escolar/app/shared/model/Responsavel.dart';
import 'package:acompanhamento_escolar/app/shared/util/UsuarioFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class DirecaoController {
  BehaviorSubject _streamController = BehaviorSubject();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  final controllerAluno = TextEditingController();
  final controllerNomeResponsavel = TextEditingController();
  final controllerEmailResponsavel = TextEditingController();
  final controllerEmailProfessor = TextEditingController();

  String mensagemErro = "";

  deslogarUsuario() async {
    UsuarioFirebase.getDeslogar();
    Modular.to.navigator.pushReplacementNamed("/");
  }

  cadastrarAluno(String nomeAluno, String nomeResponsavel) {
    UsuarioFirebase.getUsuarioAtual().then((firebaseUser) {});
    Aluno aluno = Aluno();
    aluno.nomeAluno = nomeAluno;
    aluno.nomeResponsavel = nomeResponsavel;

    if (nomeAluno.isNotEmpty && nomeResponsavel.isNotEmpty) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("alunos")
          .doc(aluno.idAluno)
          .set(aluno.toMap())
          .catchError((error) {
        input.add(
            mensagemErro = "Erro!!! Verifique se está conectado na internet");
      });
      limparCampos();
      Modular.to.navigator.pop();
    }
  }

  adicionarResponsavel(String nome, String email) {
    Responsavel responsavel = Responsavel();
    responsavel.nome = nome;
    responsavel.email = email;

    if (email.isNotEmpty) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("responsaveis")
          .add(responsavel.toMap())
          .catchError((error) {
        input.add(
            mensagemErro = "Erro!!! Verifique se está conectado na internet");
      });
      limparCampos();
      Modular.to.navigator.pop();
    }
  }

  adicionarProfessor(String email) {
    Professor professor = Professor();
    professor.email = email;

    if (email.isNotEmpty) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("professores").add(professor.toMap()).catchError((error) {
        input.add(
            mensagemErro = "Erro!!! Verifique se está conectado na internet");
      });
      limparCampos();
      Modular.to.navigator.pop();
    }
  }

  limparCampos() {
    controllerAluno.clear();
    controllerNomeResponsavel.clear();
    controllerEmailResponsavel.clear();
    controllerEmailProfessor.clear();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
