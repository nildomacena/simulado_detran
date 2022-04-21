import 'package:get/get.dart';
import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';

class HomeRepository {
  final FirestoreProvider firestoreProvider;

  HomeRepository({required this.firestoreProvider});

  Stream<List<ResultadoQuestionario>> streamResultados() {
    return firestoreProvider.streamResultado();
  }
}
