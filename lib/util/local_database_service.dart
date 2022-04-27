import 'package:get_storage/get_storage.dart';
import 'package:simulado_detran/exceptions/questoes_excedidas_exception.dart';
import 'package:simulado_detran/model/categoria_model.dart';
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
    box.read('questoes').forEach((m) {
      questoes.add(Questao.fromMap(m));
    });
    questoes.shuffle();
    return questoes.sublist(0, quantidade);
  }

  Questao getQuestaoAleatoria(List<Questao> questoesAnteriores,
      [Categoria? categoria]) {
    List<Questao> questoes = getQuestoes();
    if (categoria != null) {
      questoes = questoes.where((q) => q.categoria.id == categoria.id).toList();
    }
    questoes.shuffle();
    Questao questao = questoes.first;
    if (questoesAnteriores.length == questoes.length) {
      throw QuestoesExcedidasException(
          'Você respondeu todas as questões dessa categoria');
    }
    if (questoesAnteriores.where((q) => q.id == questao.id).isNotEmpty) {
      return getQuestaoAleatoria(questoesAnteriores, categoria);
    } else {
      return questao;
    }
  }

  Future<dynamic> salvarQuestionario(
    int totalQuestoes,
    int totalRespostas,
    int totalAcertos,
  ) async {
    List<Map> questionarios = box.read('questionarios') ?? [];
    Map data = {
      'totalQuestoes': totalQuestoes,
      'totalRespostas': totalRespostas,
      'totalAcertos': totalAcertos,
      'data': DateTime.now().millisecondsSinceEpoch
    };
    questionarios.add(data);
    return box.write('questionarios', questionarios);
  }

  Future<Map> setAcertosPorCategorias(
      List<Questao> questionario, List<Categoria> categorias) async {
    Map<String, Map<String, int>> map = {};
    if (box.read(KeysBox.acertosCategorias) == null) {
      for (var c in categorias) {
        map[c.id] = {'totalRespondidas': 0, 'totalAcertos': 0};
      }
    }
    for (String categoriaId in map.keys) {
      List<Questao> questoesRespondidas =
          questionario.where((q) => q.categoria.id == categoriaId).toList();
      int parcialAcertos = questionario.where((q) => q.acertou).length;
      int totalRespondidas = map[categoriaId]!['totalRespondidas']!;
      totalRespondidas += questoesRespondidas.length;
      int totalAcertos = map[categoriaId]!['totalRespondidas']!;
      totalAcertos += parcialAcertos;
      map[categoriaId] = {
        'totalRespondidas': totalRespondidas,
        'totalAcertos': totalAcertos
      };
    }

    await box.write(KeysBox.acertosCategorias, map);
    return box.read(KeysBox.acertosCategorias);
  }
}

LocalDatabaseService databaseService = LocalDatabaseService();

abstract class KeysBox {
  static const acertosCategorias = 'acertosCategorias';
}
