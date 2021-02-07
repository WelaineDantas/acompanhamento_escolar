import 'package:acompanhamento_escolar/app/shared/model/Aluno.dart';

class Nota {
  String _nota;
  String _materia;
  Aluno _aluno;

  Nota();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> dadosAluno = {
      "idAluno": this.aluno.idAluno,
      "nomeAluno": this.aluno.nomeAluno,
      "nomeResponsavel": this.aluno.nomeResponsavel,
    };

    Map<String, dynamic> dadosNota = {
      "nota": this.nota,
      "materia": this.materia,
      "aluno": dadosAluno,
    };

    return dadosNota;
  }

  String get nota => _nota;

  set nota(String value) {
    _nota = value;
  }

  String get materia => _materia;

  set materia(String value) {
    _materia = value;
  }

  Aluno get aluno => _aluno;

  set aluno(Aluno value) {
    _aluno = value;
  }
}
