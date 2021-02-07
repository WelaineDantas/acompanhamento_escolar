import 'package:cloud_firestore/cloud_firestore.dart';

class Aluno {
  String _idAluno;
  String _nomeAluno;
  String _nomeResponsavel;

  Aluno() {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference ref = db.collection("alunos").doc();
    this.idAluno = ref.id;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> dadosAluno = {
      "idAluno": this._idAluno,
      "nomeAluno": this.nomeAluno,
      "nomeResponsavel": this.nomeResponsavel,
    };

    return dadosAluno;
  }

  String get idAluno => _idAluno;

  set idAluno(String value) {
    _idAluno = value;
  }

  String get nomeAluno => _nomeAluno;

  set nomeAluno(String value) {
    _nomeAluno = value;
  }

  String get nomeResponsavel => _nomeResponsavel;

  set nomeResponsavel(String value) {
    _nomeResponsavel = value;
  }
}
