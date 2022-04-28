import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/util/local_database_service.dart';

class SplashscreenRepository {
  final FirestoreProvider firestoreProvider;
  SplashscreenRepository({required this.firestoreProvider});

  Future<dynamic> checaVersaoBancoDeDados() async {
    num versao = await firestoreProvider.getVersaoBD();
    bool atualizado = databaseService.dbQuestoesAtualizado(versao);
    print('atualizado: $atualizado');
    if (!atualizado) {
      List<Questao> questoes = await firestoreProvider.getTodasQuestoes();

      List<Categoria> categorias = await firestoreProvider.getCategorias();

      print('questoes: $questoes');

      await databaseService.armazenarQuestoes(questoes, versao);
    } else {
      return;
    }
  }
}
