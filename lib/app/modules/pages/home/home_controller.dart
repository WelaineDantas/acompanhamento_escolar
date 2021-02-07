import 'package:acompanhamento_escolar/app/shared/util/UsuarioFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeController {
  bool carregando = false;

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
  }

  verificarUsuarioLogado() async {
    User usuarioLogado = await UsuarioFirebase.getUsuarioAtual();
    if (usuarioLogado != null) {
      String idUsuario = usuarioLogado.uid;
      _redirecionarTelaPorTipoUsuario(idUsuario);
    }
  }
}
