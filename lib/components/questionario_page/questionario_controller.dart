import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_repository.dart';
import 'package:simulado_detran/model/questao_model.dart';

class QuestionarioController extends GetxController {
  List<Questao>? questionario;
  final QuestionarioRepository repository;
  QuestionarioController(this.repository) {
    print('Questionario criado');
  }

  @override
  onInit() {
    super.onInit();
    getQuestoes();
  }

  getQuestoes() async {
    print('getQuestoes');
    questionario = await repository.getQuestionario();
    print('questionário: $questionario');
  }
}
