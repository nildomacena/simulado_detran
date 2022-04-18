import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_repository.dart';
import 'package:simulado_detran/model/questao_model.dart';

class QuestionarioController extends GetxController {
  bool carregando = true;
  List<Questao>? questionario;
  late Questao questaoAtual;
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
    update();
  }

  retrocederQuestao() {
    questaoAtual = questionario![questionario!.indexOf(questaoAtual) - 1];
    update();
  }
}
