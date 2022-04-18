import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String cpf;
  String nome;
  DateTime dataCadastro;
  DateTime? vencimentoAcesso;

  Usuario(
      {required this.nome,
      required this.cpf,
      required this.dataCadastro,
      this.vencimentoAcesso});

  factory Usuario.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Usuario(
        cpf: data['cpf'],
        nome: data['nome'],
        dataCadastro: data['dataCadastro'].toDate(),
        vencimentoAcesso: data["vencimentoAcesso"] != null
            ? data['vencimentoAcesso'].toDate()
            : null);
  }
}
