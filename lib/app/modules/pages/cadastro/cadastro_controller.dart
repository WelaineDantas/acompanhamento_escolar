import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acompanhamento_escolar/app/shared/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class CadastroController {
  BehaviorSubject _streamController = BehaviorSubject();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  var controllerNome = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerSenha = TextEditingController();

  String mensagemErro = "";
  bool carregando = false;

  validarCampos(String tipoUsuarios) async {
    String nome = controllerNome.text;
    String email = controllerEmail.text;
    String senha = controllerSenha.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 5) {
          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          usuario.tipoUsuario = usuario.verificaTipoUsuario(tipoUsuarios);
          _cadastrarUsuario(usuario);
        } else {
          input.add(mensagemErro = "A senha deve conter mais de 5 caracteres");
        }
      } else {
        input.add(mensagemErro = "Preencha um e-mail válido");
      }
    } else {
      input.add(mensagemErro = "Preencha o Nome");
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    //carregando = true;

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth
        .createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firebaseUser) {
      db.collection("usuarios").doc(firebaseUser.user.uid).set(usuario.toMap());

      switch (usuario.tipoUsuario) {
        case "Responsavel":
          Modular.to.navigator.restorablePushNamedAndRemoveUntil(
            "/RESPONSAVEL",
            (route) => false,
          );
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
    }).catchError((error) {
      input.add(mensagemErro =
          "Erro ao cadastrar usuário!!! Verifique o e-mail e a senha.");
    });
    limparCampos();
  }

  limparCampos() {
    controllerNome.clear();
    controllerEmail.clear();
    controllerSenha.clear();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
