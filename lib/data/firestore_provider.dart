import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulado_detran/components/util/util_service.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/usuario_model.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Categoria>> getCategorias() async {
    QuerySnapshot snapshot = await _firestore.collection('categorias').get();
    return snapshot.docs.map((e) => Categoria.fromFirestore(e)).toList();
  }

  Future<bool> checkUsuario(String cpf) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('usuarios')
        .where('cpf', isEqualTo: cpf)
        .get();
    if (querySnapshot.docs.isEmpty) return false;
    Usuario usuario = Usuario.fromFirestore(querySnapshot.docs.first);
    return usuario.vencimentoAcesso == null ||
        usuario.vencimentoAcesso!.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch;
  }

  Future<List<Questao>> getQuestionario(int numQuestoes) async {
    List<Questao> questoes = [];
    for (int i = 0; i < numQuestoes; i++) {
      Questao? questao = await addQuestao(questoes);
      do {
        questao = await addQuestao(questoes);
      } while (questao == null);
      questoes.add(questao);
      /* Questao questao = await getQuestaoAleatoria();
      int count = 0;
      bool jaConsta = false;

      if (questoes.isEmpty) {
        questoes.add(questao);
      } else {
        jaConsta = questoes.where((Questao q) => q.id == questao.id).isNotEmpty;
        do {
          Questao questao = await getQuestaoAleatoria();
          jaConsta =
              questoes.where((Questao q) => q.id == questao.id).isNotEmpty;
          print('jaConsta: $jaConsta');
        } while (jaConsta);
        questoes.add(questao); */
      /* do {
          questao = await getQuestaoAleatoria();
          questoes.add(questao);
          print('count: $count');
          count++;
        } while (questoes.where((Questao q) => q.id == questao.id).isNotEmpty &&
            count < numQuestoes); */
    }
    /*  if (questoes.isEmpty) {
        questoes.add(questao);
      } else {
        while (questoes.where((Questao q) => q.id == questao.id).isEmpty) {
          print('count: $count');
          questao = await getQuestaoAleatoria();
          questoes.add(questao);
          count++;
        }
        /*  do {
          questao = await getQuestaoAleatoria();
          questoes.add(questao);
          print('count: $count');
          count++;
        } while (questoes.where((Questao q) => q.id == questao.id).isNotEmpty &&
            //    questoes.isEmpty ||
            count < numQuestoes); */
      } */
    /*  while (questoes.where((Questao q) => q.id == questao.id).isEmpty ||
          questoes.isEmpty) {
        print('count: $count');
        questao = await getQuestaoAleatoria();
        count++;
      } */

    List ids = [];
    for (var q in questoes) {
      if (ids.contains(q.id)) {
        print("duplicate ${q.id}");
      } else {
        ids.add(q.id);
      }
    }
    return questoes;
  }

  Future<Questao?> addQuestao(List<Questao> questoes) async {
    Questao questao = await getQuestaoAleatoria();
    if (questoes.where((Questao q) => q.id == questao.id).isEmpty) {
      return questao;
    } else {
      addQuestao(questoes);
      return Future.value(null);
    }
  }

  Future<Questao> getQuestaoAleatoria() async {
    QuerySnapshot querySnapshot;
    int random = utilService.gerarRandomQuestao();
    querySnapshot = await _firestore
        .collection('questoes')
        .where('random', isGreaterThanOrEqualTo: random)
        .orderBy('random', descending: false)
        .limit(1)
        .get();
    if (querySnapshot.docs.isEmpty) {
      querySnapshot = await _firestore
          .collection('questoes')
          .where('random', isLessThanOrEqualTo: random)
          .orderBy('random', descending: false)
          .limit(1)
          .get();
    }
    return Questao.fromFirestore(querySnapshot.docs.first);
  }
}
