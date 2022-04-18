import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria {
  String nome;
  String? imagem;

  Categoria({required this.nome, this.imagem});

  factory Categoria.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Categoria(nome: data['nome'], imagem: data['imagem']);
  }

  factory Categoria.fromMap(Map<String, dynamic> data) {
    return Categoria(nome: data['nome'], imagem: data['imagem']);
  }
}
