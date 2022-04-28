import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/analise_categoria_model.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:simulado_detran/util/local_database_service.dart';

class ProgressoRepository {
  final FirestoreProvider firestoreProvider;

  ProgressoRepository({required this.firestoreProvider});

  Stream<List<ResultadoQuestionario>> streamResultados() {
    return firestoreProvider.streamResultado();
  }

  Future<List<AnaliseCategoria>> getAnaliseCategorias() async {
    List<Categoria> categorias = await databaseService.getCategorias();
    if (categorias.isEmpty) {
      categorias = await firestoreProvider.getCategorias();
    }
    return databaseService.getAcertosPorCategorias(categorias);

    /* 
    List<AnaliseCategoria> analiseCategoria = [];
    for (String id in map.keys) {
      analiseCategoria.add(AnaliseCategoria(
          categoria: categorias.firstWhere((c) => c.id == id),
          questoesRespondidas: map[id]['totalRespondidas'],
          acertos: map[id]['totalAcertos']));
    }
    return analiseCategoria; */
  }
}
