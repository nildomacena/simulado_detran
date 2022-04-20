import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/login_page/login_controller.dart';
import 'package:simulado_detran/widgets/loading_widget.dart';

class PrimeiroAcessoPage extends StatelessWidget {
  LoginController controller = Get.find();
  PrimeiroAcessoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primeiro Acesso')),
      body: Container(
        alignment: Alignment.center,
        child: Form(
            key: controller.formKeyPrimeiroAcesso,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              shrinkWrap: true,
              children: [
                const Text(
                  'Preencha as informações',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                const Divider(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: controller.validatorCpf,
                  controller: controller.cpfTextController,
                  inputFormatters: [controller.maskFormatter],
                  decoration: const InputDecoration(label: Text('CPF')),
                ),
                TextFormField(
                  validator: controller.validatorNome,
                  controller: controller.nomeTextController,
                  keyboardType: TextInputType.name,
                  decoration:
                      const InputDecoration(label: Text('Nome completo')),
                ),
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
                TextFormField(
                  controller: controller.confirmaSenhaTextController,
                  validator: controller.validatorConfirmaSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(label: Text('Repita a senha')),
                ),
                GetBuilder<LoginController>(
                  builder: (_) {
                    return SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                            onPressed: _.carregando
                                ? null
                                : () {
                                    controller.criarUsuario();
                                  },
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(Get.width, 60),
                                primary: Colors.deepOrange),
                            child: _.carregando
                                ? const LoadingWidget()
                                : const Text(
                                    'Salvar Cadastro',
                                    style: TextStyle(fontSize: 18),
                                  )));
                  },
                )
              ],
            )),
      ),
    );
  }
}
