import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/login_page/login_repository.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:simulado_detran/components/login_page/widgets/primeiro_acesso_page.dart';
import 'package:simulado_detran/exceptions/auth_exceptions.dart';
import 'package:simulado_detran/util/util_service.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKeyPrimeiroAcesso = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  bool carregando = false;
  TextEditingController cpfTextController = TextEditingController();
  TextEditingController nomeTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController senhaTextController = TextEditingController();
  TextEditingController confirmaSenhaTextController = TextEditingController();

  FocusNode focusCpf = FocusNode();
  FocusNode focusNome = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusSenha = FocusNode();
  FocusNode focusConfirmaSenha = FocusNode();

  bool primeiroAcesso = false;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
  );
  final LoginRepository repository;

  LoginController(this.repository) {
    DateTime hoje = DateTime.now();
    print(DateTime.fromMillisecondsSinceEpoch(
        hoje.millisecondsSinceEpoch + utilService.diasEmMilisseconds(30)));
    print(hoje);
  }

  @override
  onInit() {
    super.onInit();
    if (repository.estaLogado()) {
      Future.delayed(const Duration(seconds: 1))
          .then((value) => Get.offAllNamed(Routes.home));
    }
  }

  irParaPrimeiroAcesso() async {
    primeiroAcesso = true;
    Get.to(() => PrimeiroAcessoPage(), fullscreenDialog: true);
    primeiroAcesso = false;
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
    if (value != confirmaSenhaTextController.text && primeiroAcesso) {
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

  onSubmitEmail() {
    focusEmail.unfocus();
    focusSenha.requestFocus();
  }

  onSubmitNome() {
    focusNome.unfocus();
    focusEmail.requestFocus();
  }

  onSubmitSenha() {
    if (primeiroAcesso) {
      focusSenha.unfocus();
      focusConfirmaSenha.requestFocus();
    } else {
      focusSenha.unfocus();
      fazerLogin();
    }
  }

  onSubmitCpf() {
    focusCpf.unfocus();
    focusNome.requestFocus();
  }

  onSubmitConfirmaSenha() {
    focusConfirmaSenha.unfocus();
    criarUsuario();
  }

  fazerLogin() async {
    if (!formKeyLogin.currentState!.validate()) {
      print('Criar usuário válido');
      utilService.snackBarErro(
          mensagem: 'Preencha as informações corretamente.');
      return;
    }
    carregando = true;
    update();
    try {
      await repository.fazerLogin(
          emailTextController.text, senhaTextController.text);
      utilService.showToast('Bem vindo de volta!');
      Get.offAllNamed(Routes.home);
    } on AutenticacaoException catch (e) {
      utilService.snackBarErro(mensagem: e.mensagem);
    } catch (e) {
      utilService.snackBarErro(mensagem: 'Ocorreu um erro durante o login');
      print('Erro ao fazer login: $e');
    } finally {
      carregando = false;
      update();
    }
  }

  criarUsuario() async {
    if (!formKeyPrimeiroAcesso.currentState!.validate()) {
      print('Criar usuário válido');
      utilService.snackBarErro(
          mensagem: 'Preencha as informações corretamente.');
      return;
    }
    carregando = true;
    update();
    try {
      print('CPF: ${maskFormatter.getUnmaskedText()} ');
      await repository.criarUsuario(
          emailTextController.text,
          senhaTextController.text,
          nomeTextController.text,
          maskFormatter.getUnmaskedText());
      utilService.showToast('Usuário criado!');
      Get.offAllNamed(Routes.home);
    } on AutenticacaoException catch (e) {
      utilService.snackBarErro(mensagem: e.mensagem);
    } catch (e) {
      utilService.snackBarErro(mensagem: 'Ocorreu um erro durante o login');
    } finally {
      carregando = false;
      update();
    }
  }
}
