import 'package:acompanhamento_escolar/app/modules/pages/cadastro/cadastro_controller.dart';
import 'package:acompanhamento_escolar/app/modules/pages/cadastro/cadastro_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/direcao/direcao_controller.dart';
import 'package:acompanhamento_escolar/app/modules/pages/direcao/direcao_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/home/home_controller.dart';
import 'package:acompanhamento_escolar/app/modules/pages/login/login_controller.dart';
import 'package:acompanhamento_escolar/app/modules/pages/home/home_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/login/login_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/notas/notas_controller.dart';
import 'package:acompanhamento_escolar/app/modules/pages/notas/notas_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/professor/professor_controller.dart';
import 'package:acompanhamento_escolar/app/modules/pages/professor/professor_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/responsavel/responsavel_page.dart';
import 'package:acompanhamento_escolar/app/modules/pages/tipo_usuario/tipo_usuario_page.dart';
import 'app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:acompanhamento_escolar/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        Bind((i) => LoginController()),
        Bind((i) => CadastroController()),
        Bind((i) => ProfessorController()),
        Bind((i) => DirecaoController()),
        Bind((i) => NotasController()),
        Bind((i) => HomeController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, __) => HomePage()),
        ModularRouter("/LOGIN", child: (_, __) => LoginPage()),
        ModularRouter("/TIPOUSUARIO", child: (_, __) => TipoUsuarioPage()),
        ModularRouter(
          "/CADASTRO/:tipoUsuario",
          child: (_, args) => CadastroPage(
            tipoUsuario: args.params["tipoUsuario"],
          ),
        ),
        ModularRouter("/RESPONSAVEL", child: (_, args) => ResponsavelPage()),
        ModularRouter("/PROFESSOR", child: (_, args) => ProfessorPage()),
        ModularRouter("/DIRECAO", child: (_, args) => DirecaoPage()),
        ModularRouter("/NOTAS", child: (_, args) => NotasPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
