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

  Future<dynamic> armazenarCategorias(
      List<Categoria> categorias, num versao) async {
    List<Map<String, dynamic>> listMap = [];
    listMap = categorias.map((q) => q.asMap).toList();
    await box.write('versao', versao);
    return box.write(KeysBox.categorias, listMap);
  }

  Future<List<Categoria>> getCategorias() async {
    await box.writeIfNull(KeysBox.categorias, []);
    return box
        .read(KeysBox.categorias)
        .map((c) => Categoria.fromMap(c))
        .toList();
  }

  Future<dynamic> armazenarQuestoes(List<Questao> questoes, num versao) async {
    List<Map<String, dynamic>> listMap = [];
    listMap = questoes.map((q) => q.asMap).toList();
    await box.write('versao', versao);
    return box.write(KeysBox.questoes, listMap);
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
    box.writeIfNull(KeysBox.questionarios, []);
    List questionarios = box.read(KeysBox.questionarios);
    Map data = {
      'totalQuestoes': totalQuestoes,
      'totalRespostas': totalRespostas,
      'totalAcertos': totalAcertos,
      'data': DateTime.now().millisecondsSinceEpoch
    };
    questionarios.add(data);
    return box.write(KeysBox.questionarios, questionarios);
  }

  Future<Map> setAcertosPorCategorias(
      List<Questao> questionario, List<Categoria> categorias) async {
    Map<String, Map> map = {};

    if (box.read(KeysBox.acertosCategorias) == null ||
        box.read(KeysBox.acertosCategorias)?.keys.isEmpty) {
      for (var c in categorias) {
        map[c.id] = {'totalRespondidas': 0, 'totalAcertos': 0};
      }
    } else {
      print(
          'box.read(KeysBox.acertosCategorias): ${box.read(KeysBox.acertosCategorias)}');
      map = Map<String, Map>.from(box.read(KeysBox.acertosCategorias));
    }
    for (String categoriaId in map.keys) {
      List<Questao> questoesRespondidas =
          questionario.where((q) => q.categoria.id == categoriaId).toList();

      int parcialAcertos = questoesRespondidas.where((q) => q.acertou).length;
      int totalRespondidas = map[categoriaId]!['totalRespondidas']!;
      totalRespondidas += questoesRespondidas.length;
      int totalAcertos = map[categoriaId]!['totalRespondidas']!;
      totalAcertos += parcialAcertos;
      map[categoriaId] = {
        'totalRespondidas': totalRespondidas,
        'totalAcertos': totalAcertos
      };
    }
    print('acertos por categorias: $map');
    await box.write(KeysBox.acertosCategorias, map);
    return box.read(KeysBox.acertosCategorias);
  }

  Future resetAcertosPorCategorias() {
    return box.write(KeysBox.acertosCategorias, null);
  }

  Map getAcertosPorCategorias() {
    return box.read(KeysBox.acertosCategorias);
  }
}

LocalDatabaseService databaseService = LocalDatabaseService();

abstract class KeysBox {
  static const acertosCategorias = 'acertosCategorias';
  static const questionarios = 'questionarios';
  static const categorias = 'categorias';
  static const questoes = 'questoes';
}
