import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/login_page/login_repository.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:simulado_detran/components/login_page/widgets/primeiro_acesso_page.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKeyPrimeiroAcesso = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  TextEditingController cpfTextController = TextEditingController();
  TextEditingController nomeTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController senhaTextController = TextEditingController();
  TextEditingController confirmaSenhaTextController = TextEditingController();

  MaskTextInputFormatter maskFormatter =
      MaskTextInputFormatter(mask: '###.###.###-##');
  final LoginRepository repository;

  LoginController(this.repository);

  fazerLogin() {
    Get.offAllNamed(Routes.home);
  }

  irParaPrimeiroAcesso() {
    Get.to(() => PrimeiroAcessoPage(), fullscreenDialog: true);
  }

  criarUsuario() {
    if (formKeyPrimeiroAcesso.currentState!.validate()) {
      print('Criar usuário válido');
    }
  }

  String? validatorCpf(String? value) {
    if (value == null || value.isEmpty) return 'Digite um CPF';
    if (!maskFormatter.isFill()) return 'Digite um CPF válido';
    return null;
  }

  String? validatorNome(String? value) {
    if (value == null || value.isEmpty) return 'Digite seu nome';
    if (value.length < 8) return 'Digite seu nome';
    return null;
  }

  String? validatorEmail(String? value) {
    if (value == null || value.isEmpty) return 'Digite seu email';
    if (!value.isEmail) return 'Digite um endereço de email válido';
    return null;
  }

  String? validatorSenha(String? value) {
    if (value == null || value.isEmpty) return 'Digite a senha';
    if (value.length < 5) return 'A senha deve ter no mínimo 6 caracteres';
    if (value != confirmaSenhaTextController.text) {
      return 'As senhas devem ser iguais';
    }
    return null;
  }

  String? validatorConfirmaSenha(String? value) {
    if (value == null || value.isEmpty) return 'Repita a senha';
    if (value.length < 5) return 'A senha deve ter no mínimo 6 caracteres';
    if (value != senhaTextController.text) {
      return 'As senhas devem ser iguais';
    }
    return null;
  }
}
