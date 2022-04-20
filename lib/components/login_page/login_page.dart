import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/login_page/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.find();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: controller.emailTextController,
              validator: controller.validatorEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(label: Text('Email')),
            ),
            TextFormField(
              validator: controller.validatorSenha,
              controller: controller.senhaTextController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(label: Text('Senha')),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    controller.fazerLogin();
                  },
                  child: const Text('ENTRAR'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(Get.width, 45),
                      primary: Colors.deepOrange),
                )),
            Container(
              child: TextButton(
                child: Text('Primeiro acesso? Clique aqui.'),
                onPressed: () {
                  controller.irParaPrimeiroAcesso();
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
