import 'package:simulado_detran/components/resultado_page/resultado_controller.dart';
import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';

class QuestionarioRepository {
  final FirestoreProvider firestoreProvider;
  QuestionarioRepository({required this.firestoreProvider});

  Future<List<Questao>> getQuestionario([int? numQuestoes]) {
    return firestoreProvider.getQuestionario(numQuestoes ?? 10);
  }

  Future<List<Questao>> getQuestionarioAvulso() async {
    Questao questao = await firestoreProvider.getQuestaoAleatoria();
    return [questao];
  }

  Future<List<Questao>> getProximaQuestaoAvulsa(
      List<Questao> questionario) async {
    Questao questao = (await firestoreProvider.addQuestao(questionario));

    return [...questionario, questao];
  }

  Future<dynamic> finalizarQuestionario(List<Questao> questionario) {
    int totalQuestoes = questionario.length;
    int totalRespostas = questionario.where((q) => q.resposta != null).length;
    int totalAcertos = questionario.where((q) => q.acertou).length;
    return firestoreProvider.salvarQuestionarioRespondido(
        totalQuestoes, totalRespostas, totalAcertos);
  }
}
