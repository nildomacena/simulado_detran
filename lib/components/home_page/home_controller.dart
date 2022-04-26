import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';
import 'package:simulado_detran/components/home_page/widgets/icone_menu_model.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:simulado_detran/routes/app_routes.dart';
import 'package:simulado_detran/util/local_database_service.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  final RxList<ResultadoQuestionario> _resultados =
      RxList<ResultadoQuestionario>();
  List<Categoria> categorias = [];
  List<ResultadoQuestionario> get resultados => _resultados.toList();

  HomeController(this.repository) {
    _resultados.bindStream(repository.streamResultados());
    /* resultados.listen((resultados) {
      print('resultados: $resultados');
    }); */
  }

  @override
  onInit() async {
    super.onInit();
    categorias = await repository.getCategorias();
    update();
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
        ...categorias.map((c) => IconeMenu(
            titulo: c.nome,
            imagem: Image.asset('assets/imagens/${c.imagem}'),
            onPressed: () {
              irParaAvulso(c);
            }))
        /* IconeMenu(
            titulo: 'Cidadania',
            imagem: Image.asset('assets/imagens/cidadania.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Direção Defensiva',
            imagem: Image.asset('assets/imagens/direcao.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Meio Ambiente',
            imagem: Image.asset('assets/imagens/ambiente.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Legislação',
            imagem: Image.asset('assets/imagens/legislacao.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Mecânica básica',
            imagem: Image.asset('assets/imagens/mecanica.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Primeiros Socorros',
            imagem: Image.asset('assets/imagens/socorro.png'),
            onPressed: () {
              irParaAvulso();
            }),
        IconeMenu(
            titulo: 'Sinalização de Trânsito',
            imagem: Image.asset('assets/imagens/placas.png'),
            onPressed: () {}), */
      ];

  irParaSimulado() {
    /* Testes */
    /*  databaseService.getQuestoes();
    return; */
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': true, 'avulso': false});
  }

  irParaAvulso([Categoria? categoria]) {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': false, 'avulso': true, 'categoria': categoria});
  }
}
