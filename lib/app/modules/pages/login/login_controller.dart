import 'dart:async';
import 'package:acompanhamento_escolar/app/shared/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class LoginController {
  var controllerEmail = TextEditingController();
  var controllerSenha = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String mensagemErro = "";
  bool carregando = false;

  var _streamController = BehaviorSubject();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  validarCampos() {
    String email = controllerEmail.text;
    String senha = controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 5) {
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
      } else {
        input.add(mensagemErro = "A senha deve conter mais de 5 caracteres");
      }
    } else {
      input.add(mensagemErro = "Preencha um e-mail válido");
    }
  }

  _logarUsuario(Usuario usuario) {
    carregando = true;

    auth
        .signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firebaseUser) {
      _redirecionarTelaPorTipoUsuario(firebaseUser.user.uid);
    }).catchError((error) {
      input.add(mensagemErro = "Erro!!! Verifique o e-mail e a senha.");
    });
  }

  _redirecionarTelaPorTipoUsuario(String idUsuario) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("usuarios").doc(idUsuario).get();
    Map<String, dynamic> dados = snapshot.data();
    String tipoUsuario = dados["tipoUsuario"];

    carregando = false;

    switch (tipoUsuario) {
      case "Responsavel":
        Modular.to.navigator.restorablePushNamedAndRemoveUntil(
            "/RESPONSAVEL", (route) => false);

        break;
      case "Professor":
        Modular.to.navigator.restorablePushNamedAndRemoveUntil(
          "/PROFESSOR",
          (route) => false,
        );
        break;
      case "Direcao":
        Modular.to.navigator.restorablePushNamedAndRemoveUntil(
          "/DIRECAO",
          (route) => false,
        );
        break;
    }
    limparCampos();
  }

  recuperarSenha() {
    String email = controllerEmail.text;

    auth.sendPasswordResetEmail(email: email);
    limparCampos();
    Modular.to.navigator.pop();
  }

  limparCampos() {
    controllerEmail.clear();
    controllerSenha.clear();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
