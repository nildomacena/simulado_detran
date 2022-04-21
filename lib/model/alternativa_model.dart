import 'package:cloud_firestore/cloud_firestore.dart';

class Alternativa {
  String texto;
  bool correta;
  String id;
  Alternativa({required this.id, required this.texto, required this.correta});

  factory Alternativa.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Alternativa(
        id: snapshot.id, texto: data['texto'], correta: data['correta']);
  }

  factory Alternativa.fromMap(Map<String, dynamic> data) {
    return Alternativa(
        id: data['id'] ?? '', texto: data['texto'], correta: data['correta']);
  }

  Map<String, dynamic> get asMap => {
        'id': id,
        'correta': correta,
        'texto': texto,
      };

  @override
  String toString() {
    return texto;
  }
}
