import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/login_page/login_controller.dart';
import 'package:simulado_detran/widgets/loading_widget.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.find();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: Form(
          key: controller.formKeyLogin,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
              const SizedBox(
                height: 10,
              ),
              GetBuilder<LoginController>(
                builder: (_) {
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _.carregando
                            ? null
                            : () {
                                controller.fazerLogin();
                              },
                        child: _.carregando
                            ? const LoadingWidget()
                            : const Text('ENTRAR'),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(Get.width, 60),
                            primary: Colors.deepOrange),
                      ));
                },
              ),
              Container(
                child: TextButton(
                  child: const Text(
                    'Primeiro acesso? Clique aqui.',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onPressed: () {
                    controller.irParaPrimeiroAcesso();
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
