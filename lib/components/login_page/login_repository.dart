import 'package:get/get.dart';
import 'package:simulado_detran/data/firestore_provider.dart';
import 'package:simulado_detran/util/util_service.dart';

class LoginRepository {
  final FirestoreProvider firestoreProvider = Get.find();

  Future fazerLogin(String email, String senha) async {
    return firestoreProvider.fazerLogin(email, senha);
  }

  Future criarUsuario(
      String email, String senha, String nome, String cpf) async {
    bool usuarioJaCadastrado =
        await firestoreProvider.checkUsuarioJaCadastrado(email);
    if (usuarioJaCadastrado) {
      utilService.showToast('Usuário já cadastrado. Realizando login...');
      return fazerLogin(email, senha);
    }
    return firestoreProvider.criarUsuario(email, nome, cpf, senha);
  }
}
