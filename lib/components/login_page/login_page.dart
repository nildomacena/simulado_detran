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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: controller.cpfTextController,
              inputFormatters: [controller.maskFormatter],
              decoration: const InputDecoration(label: Text('CPF')),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  controller.fazerLogin();
                },
                child: const Text('ENTRAR'),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width, 45), primary: Colors.deepOrange),
              ))
        ],
      )),
    );
  }
}
