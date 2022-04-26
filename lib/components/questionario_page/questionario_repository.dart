import 'package:simulado_detran/components/resultado_page/resultado_controller.dart';
import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/exceptions/questoes_excedidas_exception.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:simulado_detran/util/local_database_service.dart';

class QuestionarioRepository {
  final FirestoreProvider firestoreProvider;
  QuestionarioRepository({required this.firestoreProvider});

  Future<List<Questao>> getQuestionario([int? numQuestoes]) async {
    List<Questao> questoes = databaseService.getQuestoes();
    print('questoes box: $questoes');
    if (questoes.isNotEmpty) return questoes;
    return firestoreProvider.getQuestionario(numQuestoes ?? 10);
  }

  Future<List<Questao>> getQuestionarioAvulso([Categoria? categoria]) async {
    Questao questao = await firestoreProvider.getQuestaoAleatoria(categoria);
    return [questao];
  }

  Future<List<Questao>> getProximaQuestaoAvulsa(List<Questao> questionario,
      [Categoria? categoria]) async {
    /*  Questao questao =
        (await firestoreProvider.addQuestao(questionario, categoria)); */
    try {
      Questao questao =
          databaseService.getQuestaoAleatoria(questionario, categoria);
      print(
          'questionario.contains(questao): ${questionario.contains(questao)}');
      if (questionario.contains(questao)) {
        throw QuestoesExcedidasException(
            'Você respondeu todas as questões dessa categoria');
      }
      return [...questionario, questao];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> finalizarQuestionario(List<Questao> questionario) async {
    int totalQuestoes = questionario.length;
    int totalRespostas = questionario.where((q) => q.resposta != null).length;
    int totalAcertos = questionario.where((q) => q.acertou).length;
    await databaseService.salvarQuestionario(
        totalQuestoes, totalRespostas, totalAcertos);
    return firestoreProvider.salvarQuestionarioRespondido(
        totalQuestoes, totalRespostas, totalAcertos);
  }
}
