import 'package:cloud_firestore/cloud_firestore.dart';

class Alternativa {
  String texto;
  bool correta;

  Alternativa({required this.texto, required this.correta});

  factory Alternativa.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Alternativa(texto: data['texto'], correta: data['correta']);
  }

  factory Alternativa.fromMap(Map<String, dynamic> data) {
    return Alternativa(texto: data['texto'], correta: data['correta']);
  }

  @override
  String toString() {
    return texto;
  }
}
