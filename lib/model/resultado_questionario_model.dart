import 'package:cloud_firestore/cloud_firestore.dart';

class ResultadoQuestionario {
  final int totalQuestoes;
  final int totalRespostas;
  final int totalAcertos;
  final DateTime data;
  final String id;

  String get dataFormatada =>
      '${(data.day).toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}';

  ResultadoQuestionario(
      {required this.id,
      required this.totalQuestoes,
      required this.totalRespostas,
      required this.totalAcertos,
      required this.data});

  factory ResultadoQuestionario.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ResultadoQuestionario(
        id: snapshot.id,
        totalQuestoes: data['totalQuestoes'],
        totalRespostas: data['totalRespostas'],
        totalAcertos: data['totalAcertos'],
        data: data['data'] == null ? DateTime.now() : data['data'].toDate());
  }

  @override
  String toString() {
    return 'Total acertos: $totalAcertos/$totalQuestoes - ID: $id';
  }
}
