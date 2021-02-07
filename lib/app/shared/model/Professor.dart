class Professor {
  String _idProfessor;
  String _email;

  Professor();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> dadosProfessor = {
      "email": this.email,
    };

    return dadosProfessor;
  }

  String get idProfessor => _idProfessor;

  set idProfessor(String value) {
    _idProfessor = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
