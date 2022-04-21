import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simulado_detran/util/util_service.dart';
import 'package:simulado_detran/exceptions/auth_exceptions.dart';
import 'package:simulado_detran/model/categoria_model.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/usuario_model.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  FirestoreProvider() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      print('user: ${_auth.currentUser}');
      if (_auth.currentUser == null && box.read('email') && box.read('senha')) {
        fazerLogin(box.read('email'), box.read('senha'));
      }
    });
  }

  bool estaLogado() {
    return _auth.currentUser != null;
  }

  Future<List<Categoria>> getCategorias() async {
    QuerySnapshot snapshot = await _firestore.collection('categorias').get();
    return snapshot.docs.map((e) => Categoria.fromFirestore(e)).toList();
  }

  Future criarUsuario(
      String email, String nome, String cpf, String senha) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('preCadastros')
        .where('cpf', isEqualTo: cpf)
        .get();
    if (querySnapshot.docs.isEmpty) {
      throw AutenticacaoException(
          'Seu CPF não foi registrado. Fale com a Auto-escola para liberar seu cadastro.');
    }
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: senha);
    box.write('senha', senha);
    box.write('email', email);
    return _firestore.doc('usuarios/${userCredential.user!.uid}').set({
      'email': email,
      'nome': nome,
      'cpf': cpf,
      'dataCadastro': (querySnapshot.docs.first.data()
          as Map<String, dynamic>)['dataCadastro']
    });
  }

  fazerLogin(String email, String senha) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isEmpty) {
      throw AutenticacaoException(
          'Email ainda não cadastrado. Acesse a opção Primeiro Acesso');
    }
    print('querySnapshot.docs.first: ${querySnapshot.docs.first.data()}');
    Usuario usuario = Usuario.fromFirestore(querySnapshot.docs.first);
    if (!utilService.checkValidadeAcesso(usuario.dataCadastro, 30)) {
      throw AutenticacaoException(
          'Sua licença para acesso ao simulado expirou.');
    }

    await _auth.signInWithEmailAndPassword(email: email, password: senha);
    box.write('senha', senha);
    box.write('email', email);
    return getUsuario();
  }

  Future<bool> checkUsuarioJaCadastrado(String email) async {
    QuerySnapshot snapshot = await _firestore
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<Usuario?> getUsuario() async {
    if (_auth.currentUser == null) {
      return null;
    }
    return Usuario.fromFirestore(
        await _firestore.doc('usuarios/${_auth.currentUser!.uid}').get());
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
    }

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

  Future<Questao> addQuestao(List<Questao> questoes) async {
    Questao questao = await getQuestaoAleatoria();
    if (questoes.where((Questao q) => q.id == questao.id).isEmpty) {
      return questao;
    } else {
      print('achou questao igual');
      return addQuestao(questoes);
      //return Future.value(null);
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
