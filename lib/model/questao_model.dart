import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulado_detran/model/alternativa_model.dart';
import 'package:simulado_detran/model/categoria_model.dart';

class Questao {
  String id;
  String enunciado;
  String? imagem;
  List<Alternativa> alternativas;
  Categoria categoria;
  Alternativa? resposta;
  Questao(
      {required this.enunciado,
      required this.alternativas,
      required this.id,
      required this.categoria,
      this.resposta,
      this.imagem});

  Alternativa get alternativaCorreta =>
      alternativas.firstWhere((a) => a.correta);

  bool get acertou => resposta == null ? false : alternativaCorreta == resposta;

  factory Questao.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<Alternativa> alternativas = (data['alternativas'] as List)
        .map((d) => Alternativa.fromMap(d))
        .toList();
    alternativas.shuffle();
    Categoria categoria = Categoria.fromMap(data['categoria']);
    return Questao(
        id: snapshot.id,
        enunciado: data['enunciado'],
        alternativas: alternativas,
        categoria: categoria,
        imagem: data['imagem']);
  }

  factory Questao.fromMap(Map<String, dynamic> data) {
    List<Alternativa> alternativas = (data['alternativas'] as List)
        .map((d) => Alternativa.fromMap(d))
        .toList();
    alternativas.shuffle();
    Categoria categoria = Categoria.fromMap(data['categoria']);
    return Questao(
        id: data['id'],
        enunciado: data['enunciado'],
        alternativas: alternativas,
        categoria: categoria,
        imagem: data['imagem']);
  }

  Map<String, dynamic> get asMap {
    return {
      'id': id,
      'enunciado': enunciado,
      'imagem': imagem,
      'alternativas': alternativas.map((a) => a.asMap).toList(),
      'categoria': categoria.asMap,
      'resposta': resposta?.asMap ?? '',
    };
  }

  @override
  String toString() {
    return id;
  }
}
