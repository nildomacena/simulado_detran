import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';
import 'package:simulado_detran/components/home_page/widgets/icone_menu_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:simulado_detran/routes/app_routes.dart';
import 'package:simulado_detran/util/util_service.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  final RxList<ResultadoQuestionario> _resultados =
      RxList<ResultadoQuestionario>();

  List<ResultadoQuestionario> get resultados => _resultados.toList();

  HomeController(this.repository) {
    _resultados.bindStream(repository.streamResultados());
    /* resultados.listen((resultados) {
      print('resultados: $resultados');
    }); */
  }
  List<IconeMenu> generateMenuItens() => [
        IconeMenu(
            titulo: 'Fazer Simulado',
            imagem: Image.asset('assets/imagens/simulado.png'),
            onPressed: () {
              irParaSimulado();
            }),
        IconeMenu(
            titulo: 'Questões aleatórias',
            imagem: Image.asset('assets/imagens/aleatorio.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Cidadania',
            imagem: Image.asset('assets/imagens/cidadania.png'),
            onPressed: () {}),
        IconeMenu(
            titulo: 'Direção Defensiva',
            imagem: Image.asset('assets/imagens/direcao.png'),
            onPressed: () {}),
        IconeMenu(
            titulo: 'Meio Ambiente',
            imagem: Image.asset('assets/imagens/ambiente.png'),
            onPressed: () {}),
        IconeMenu(
            titulo: 'Legislação',
            imagem: Image.asset('assets/imagens/legislacao.png'),
            onPressed: () {}),
        IconeMenu(
            titulo: 'Mecânica básica',
            imagem: Image.asset('assets/imagens/mecanica.png'),
            onPressed: () {}),
        IconeMenu(
            titulo: 'Primeiros Socorros',
            imagem: Image.asset('assets/imagens/socorro.png'),
            onPressed: () {}),
        IconeMenu(
            titulo: 'Placas',
            imagem: Image.asset('assets/imagens/placas.png'),
            onPressed: () {}),
      ];

  irParaSimulado() {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': true, 'avulso': false});
  }

  irParaAvulso() {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': false, 'avulso': true});
  }
}
