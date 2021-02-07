import 'dart:async';
import 'package:acompanhamento_escolar/app/shared/model/Usuario.dart';
import 'package:acompanhamento_escolar/app/shared/util/UsuarioFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NotasController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final controller = BehaviorSubject<QuerySnapshot>();
  final controllerUsuarioAtual = BehaviorSubject<String>();
  final _controllerAluno = BehaviorSubject();

  Sink get inputAluno => _controllerAluno.sink;
  Stream get outputAluno => _controllerAluno.stream;

  String nomeAluno;
  String materia;
  String nota;
  String usuarioAtual = "";

  verificarResponsaveldoAluno() async {
    Usuario usuario = await UsuarioFirebase.getDadosUsuarioAtual();

    controllerUsuarioAtual.add(usuarioAtual = usuario.nome);
  }

  Stream<QuerySnapshot> adicionarListenerNotas() {
    final stream = db.collection("notas").snapshots();
    stream.listen((dados) {
      controller.sink.add(dados);
    });
  }

  var mensagemCarregando = Center(
    child: Column(
      children: [
        Text("Carregando lista de notas"),
        CircularProgressIndicator()
      ],
    ),
  );

  var mensagemSemDados = Center(
    child: Text("Não tem aluno cadastrado"),
  );

  @override
  void dispose() {
    controller.close();
    controllerUsuarioAtual.close();
    _controllerAluno.close();
  }
}
