class Responsavel {
  String _idResponsavel;
  String _nome;
  String _email;

  Responsavel();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> dadosResponsavel = {
      "email": this.email,
      "nome": this.nome,
    };

    return dadosResponsavel;
  }

  String get idResponsavel => _idResponsavel;

  set idResponsavel(String value) {
    _idResponsavel = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
