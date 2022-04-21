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
                  focusNode: controller.focusCpf,
                  controller: controller.cpfTextController,
                  inputFormatters: [controller.maskFormatter],
                  decoration: const InputDecoration(label: Text('CPF')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (str) {
                    controller.onSubmitCpf();
                  },
                ),
                TextFormField(
                  validator: controller.validatorNome,
                  controller: controller.nomeTextController,
                  focusNode: controller.focusNome,
                  keyboardType: TextInputType.name,
                  decoration:
                      const InputDecoration(label: Text('Nome completo')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (str) {
                    controller.onSubmitNome();
                  },
                ),
                TextFormField(
                  controller: controller.emailTextController,
                  focusNode: controller.focusEmail,
                  validator: controller.validatorEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(label: Text('Email')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (str) {
                    controller.onSubmitEmail();
                  },
                ),
                TextFormField(
                  validator: controller.validatorSenha,
                  focusNode: controller.focusSenha,
                  controller: controller.senhaTextController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(label: Text('Senha')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (str) {
                    controller.onSubmitSenha();
                  },
                ),
                TextFormField(
                  controller: controller.confirmaSenhaTextController,
                  focusNode: controller.focusConfirmaSenha,
                  validator: controller.validatorConfirmaSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(label: Text('Repita a senha')),
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (str) {
                    controller.onSubmitConfirmaSenha();
                  },
                ),
                const SizedBox(
                  height: 20,
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
