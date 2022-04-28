import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/analise_categoria_model.dart';
import 'package:simulado_detran/util/local_database_service.dart';

class ResultadoRepository {
  final FirestoreProvider firestoreProvider;
  ResultadoRepository({required this.firestoreProvider});

  Future<List<AnaliseCategoria>> getAnaliseCategoria() async {
    return databaseService
        .getAcertosPorCategorias(await databaseService.getCategorias());
  }
}
