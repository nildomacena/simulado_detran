import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria {
  String nome;
  String? imagem;
  String id;

  Categoria({required this.id, required this.nome, this.imagem});

  factory Categoria.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Categoria(
        id: snapshot.id, nome: data['nome'], imagem: data['imagem']);
  }

  factory Categoria.fromMap(Map<String, dynamic> data) {
    return Categoria(
        id: data['id'] ?? '', nome: data['nome'], imagem: data['imagem']);
  }

  Map<String, dynamic> get asMap => {
        'nome': nome,
        'imagem': imagem ?? '',
        'id': id,
      };
}
