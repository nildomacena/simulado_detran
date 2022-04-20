import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/resultado_page/resultado_repository.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/simulado_realizado_model.dart';

class ResultadoController extends GetxController {
  late SimuladoRealizado simuladoRealizado;
  ScrollController scrollController = ScrollController();
  final ResultadoRepository repository;
  Questao? questaoSelecionada;

  ResultadoController(this.repository);

  String get numeroQuestao => questaoSelecionada == null
      ? ''
      : (simuladoRealizado.questionario.indexOf(questaoSelecionada!) + 1)
          .toString();

  @override
  void onInit() {
    simuladoRealizado = Get.arguments;
    print('arguments: ${Get.arguments}');
    super.onInit();
  }

  selecionarQuestao(Questao questao) {
    questaoSelecionada = questaoSelecionada == questao ? null : questao;
    if (questaoSelecionada != null)
      scrollController.animateTo(1000,
          curve: Curves.linear, duration: const Duration(seconds: 1));
    update();
  }
}