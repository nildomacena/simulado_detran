import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/login_page/login_repository.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController cpfTextController = TextEditingController();
  MaskTextInputFormatter maskFormatter =
      MaskTextInputFormatter(mask: '###.###.###-##');
  final LoginRepository repository;
  LoginController(this.repository);

  fazerLogin() {
    Get.offAllNamed(Routes.home);
  }
}
