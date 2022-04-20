import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/questao_model.dart';

class QuestionarioRepository {
  final FirestoreProvider firestoreProvider;
  QuestionarioRepository({required this.firestoreProvider});

  Future<List<Questao>> getQuestionario([int? numQuestoes]) {
    return firestoreProvider.getQuestionario(numQuestoes ?? 30);
  }
}
