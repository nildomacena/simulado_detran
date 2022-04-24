import 'package:get/get.dart';
import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';

class HomeRepository {
  final FirestoreProvider firestoreProvider;

  HomeRepository({required this.firestoreProvider});

  Stream<List<ResultadoQuestionario>> streamResultados() {
    return firestoreProvider.streamResultado();
  }

  Future<List<Categoria>> getCategorias() {
    return firestoreProvider.getCategorias();
  }
}
