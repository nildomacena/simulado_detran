import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_repository.dart';
import 'package:simulado_detran/model/alternativa_model.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/simulado_realizado_model.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class QuestionarioController extends GetxController {
  bool carregando = true;
  List<Questao>? questionario;
  late Questao questaoAtual;
  Alternativa? alternativaSelecionada;
  final QuestionarioRepository repository;
  QuestionarioController(this.repository) {
    print('Questionario criado');
  }

  String get numQuestaoAtual =>
      questionario == null ? '' : '${questionario!.indexOf(questaoAtual) + 1}';

  bool get primeiraQuestao =>
      questionario != null &&
      questionario!.indexOf(questaoAtual) ==
          questionario!.indexOf(questionario!.first);

  bool get ultimaQuestao =>
      questionario != null &&
      questionario!.indexOf(questaoAtual) ==
          questionario!.indexOf(questionario!.last);

  int get questoesRespondidas => questionario == null
      ? 0
      : questionario!.where((q) => q.resposta != null).length;
  @override
  onInit() {
    super.onInit();
    getQuestoes();
  }

  getQuestoes() async {
    print('getQuestoes');
    questionario = await repository.getQuestionario();
    carregando = false;
    questaoAtual = questionario!.first;
    update();
    print('questionário: $questionario');
  }

  avancarQuestao() {
    questaoAtual = questionario![questionario!.indexOf(questaoAtual) + 1];
    alternativaSelecionada = null;
    update();
  }

  retrocederQuestao() {
    questaoAtual = questionario![questionario!.indexOf(questaoAtual) - 1];
    update();
  }

  responderQuestao() {
    if (questaoAtual != questionario!.last) {
      avancarQuestao();
    } else {
      update();
      finalizarQuestionario();
    }
  }

  Future<bool> confirmaWillPop() async {
    bool? result = await Get.dialog(AlertDialog(
      title: const Text('Deseja realmente sair?'),
      content: const Text(
          'Se você sair dessa tela, irá perder o seu progresso no questionário.\nDeseja realmente sair?'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Sair do questionário')),
      ],
    ));
    return result ?? false;
  }

  finalizarQuestionario() async {
    bool? result = await Get.dialog(AlertDialog(
      title: const Text('Finalizar Questionário'),
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Deseja finalizar o questionário?'),
            Text(
                'Questões respondidas: $questoesRespondidas/${questionario!.length}'),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('CANCELAR')),
        TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('FINALIZAR')),
      ],
    ));
    if (result != null && result) {
      //Get.back();
      Get.toNamed(Routes.resultado,
          arguments: SimuladoRealizado(questionario!));
    }
  }

  selecionaAlternativaBkp(Alternativa alternativa) {
    questaoAtual.resposta = null;
    if (alternativa == alternativaSelecionada) {
      alternativaSelecionada = null;
    } else {
      alternativaSelecionada = alternativa;
    }
    print('alternativaSelecionada: $alternativaSelecionada');
    update();
  }

  selecionaAlternativa(Alternativa alternativa) {
    if (questaoAtual.resposta == alternativa) {
      questaoAtual.resposta = null;
    } else {
      questaoAtual.resposta = alternativa;
    }
    print('alternativaSelecionada: ${questaoAtual.resposta}');
    update();
  }
}
