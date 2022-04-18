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

  factory Questao.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<Alternativa> alternativas = (data['alternativas'] as List)
        .map((d) => Alternativa.fromMap(d))
        .toList();
    Categoria categoria = Categoria.fromMap(data['categoria']);
    return Questao(
        id: snapshot.id,
        enunciado: data['enunciado'],
        alternativas: alternativas,
        categoria: categoria,
        imagem: data['imagem']);
  }

  @override
  String toString() {
    return id;
  }
}
