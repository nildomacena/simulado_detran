import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';

class ProgressoRepository {
  final FirestoreProvider firestoreProvider;

  ProgressoRepository({required this.firestoreProvider});

  Stream<List<ResultadoQuestionario>> streamResultados() {
    return firestoreProvider.streamResultado();
  }
}
