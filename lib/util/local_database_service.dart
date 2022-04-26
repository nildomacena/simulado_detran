import 'package:get_storage/get_storage.dart';
import 'package:simulado_detran/model/questao_model.dart';

class LocalDatabaseService {
  final box = GetStorage();

  bool dbQuestoesAtualizado(num versao) {
    if (box.read('questoes') == null) {
      return false;
    } else if (box.read('versao') != versao) {
      return false;
    }
    return true;
  }

  Future<dynamic> armazenarQuestoes(List<Questao> questoes, num versao) async {
    List<Map<String, dynamic>> listMap = [];
    listMap = questoes.map((q) => q.asMap).toList();
    print('box.read: ${box.read('versao')}');
    await box.write('versao', versao);
    return box.write('questoes', listMap);
  }

  List<Questao> getQuestoes([int? quantidade]) {
    List<Questao> questoes = [];
    print('box.read(questoes).length: ${box.read('questoes').length}');
    Questao questao = Questao.fromMap(box.read('questoes').first);
    print('questao from map: $questao');
    box.read('questoes').forEach((m) {
      questoes.add(Questao.fromMap(m));
    });
    questoes.shuffle();
    /* List<Questao> questoes =
        (box.read('questoes') as List<Map<String, dynamic>>)
            .map((m) => Questao.fromMap(m))
            .toList(); */
    print('questoes from map: $questoes');
    return questoes.sublist(0, quantidade);
  }
}

LocalDatabaseService databaseService = LocalDatabaseService();
