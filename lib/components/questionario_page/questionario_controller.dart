import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_repository.dart';
import 'package:simulado_detran/exceptions/questoes_excedidas_exception.dart';
import 'package:simulado_detran/model/alternativa_model.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/simulado_realizado_model.dart';
import 'package:simulado_detran/routes/app_routes.dart';
import 'package:simulado_detran/util/util_service.dart';

class QuestionarioController extends GetxController {
  bool carregando = true;
  List<Questao>? questionario;
  late Questao questaoAtual;
  Alternativa? alternativaSelecionada;
  final QuestionarioRepository repository;
  int segundosCountdown = 1800;
  bool simulado = true;
  bool avulso = false;
  Categoria? categoria;

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

  String get minutosTimer => utilService.formatarSegundo(segundosCountdown);

  bool get exibirWarning => segundosCountdown < 120;
  Timer? timer;

  QuestionarioController(this.repository);

  @override
  onInit() async {
    super.onInit();
    if (Get.arguments != null && Get.arguments['categoria'] != null) {
      categoria = Get.arguments['categoria'];
    }
    if (Get.arguments != null && Get.arguments['simulado'] != null) {
      simulado = Get.arguments['simulado'];
    }
    if (Get.arguments != null && Get.arguments['avulso'] != null) {
      avulso = Get.arguments['avulso'];
    }
    await getQuestoes();
    if (simulado) initTimer();
  }

  @override
  onClose() {
    super.onClose();
    if (timer != null) timer!.cancel();
  }

  initTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      this.timer = timer;
      segundosCountdown -= 1;
      print('segundosCountdown: $segundosCountdown');
      if (segundosCountdown <= 1) {
        onFinalizaTimer(timer);
        timer.cancel();
      }
      update();
    });
  }

  Future getQuestoes() async {
    print('getQuestoes simulado: $simulado - avulso: $avulso');
    if (simulado) {
      questionario = await repository.getQuestionario();
    } else {
      questionario = await repository.getQuestionarioAvulso(categoria);
    }
    carregando = false;
    questaoAtual = questionario!.first;
    update();
    print('question??rio: $questionario');
    return;
  }

  avancarQuestao() async {
    print('avancar questao');
    try {
      if (avulso) {
        carregando = true;
        update();
        questionario =
            await repository.getProximaQuestaoAvulsa(questionario!, categoria);
        carregando = false;
        update();
      }
      questaoAtual = questionario![questionario!.indexOf(questaoAtual) + 1];
      alternativaSelecionada = null;
      update();
    } on QuestoesExcedidasException catch (e) {
      utilService.showToast(e.mensagem);
      finalizarQuestionario(true);
    } catch (e) {
      utilService.snackBarErro(mensagem: 'Ocorreu um erro durante a pesquisa');
      print('Erro: $e');
    }
  }

  retrocederQuestao() {
    questaoAtual = questionario![questionario!.indexOf(questaoAtual) - 1];
    update();
  }

  responderQuestao() {
    if (questaoAtual != questionario!.last || avulso) {
      avancarQuestao();
    } else {
      update();
      finalizarQuestionario();
    }
  }

  onFinalizaTimer([Timer? timer]) async {
    if (timer != null) {
      timer.cancel();
    }
    if (Get.isDialogOpen ?? false) Get.back();
    Get.dialog(
      AlertDialog(
        title: const Text('Acabou o tempo!'),
        content: const Text(
            'O per??odo do simulado acabou! Deseja adicionar mais 5 minutos ou finalizar o simulado?'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                segundosCountdown += 300;
                update();
                initTimer();
              },
              child: const Text('Adicionar mais 5 minutos')),
          TextButton(
              onPressed: () {
                Get.back();
                finalizarQuestionario();
              },
              child: const Text('Finalizar simulado')),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<bool> confirmaWillPop() async {
    bool? result = await Get.dialog(AlertDialog(
      title: const Text('Deseja realmente sair?'),
      content: const Text(
          'Se voc?? sair dessa tela, ir?? perder o seu progresso no question??rio.\nDeseja realmente sair?'),
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
            child: const Text('Sair do question??rio')),
      ],
    ));
    return result ?? false;
  }

  finalizarQuestionario([bool? obrigatorio]) async {
    if (questionario == null ||
        questionario!.where((q) => q.resposta != null).isEmpty) {
      Get.back();
      return;
    }

    if (avulso && questionario!.last.resposta == null) {
      //Verifica se ?? quest??o avulso e se o usu??rio n??o selecionou a ??ltima resposta
      questionario!.removeLast();
    }
    bool? result;
    if (obrigatorio != null && obrigatorio) {
      result = true;
    } else {
      result = await Get.dialog(AlertDialog(
        title: const Text('Finalizar Question??rio'),
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Deseja finalizar o question??rio?'),
              Text(
                  'Quest??es respondidas: $questoesRespondidas/${questionario!.length}'),
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
    }

    if (result != null && result) {
      Get.back();
      repository.finalizarQuestionario(questionario!);
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
