import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/resultado_page/widgets/questao_container.dart';
import 'package:simulado_detran/components/resultado_page/resultado_controller.dart';
import 'package:simulado_detran/components/resultado_page/widgets/grid_questoes.dart';

class ResultadoPage extends StatelessWidget {
  final ResultadoController controller = Get.find();
  ResultadoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado simulado')),
      body: ListView(controller: controller.scrollController, children: [
        Container(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'Você acertou ${controller.simuladoRealizado.acertos} questões em um total de ${controller.simuladoRealizado.questionario.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
        Container(
            width: Get.width,
            alignment: Alignment.center,
            child: Text(
              '${((controller.simuladoRealizado.acertos / controller.simuladoRealizado.questionario.length) * 100).toStringAsFixed(0)}% de acerto',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          height: 30,
        ),
        GridQuestoes(
          controller: Get.find(),
          simuladoRealizado: controller.simuladoRealizado,
        ),
        const Divider(),
        GetBuilder<ResultadoController>(builder: (_) {
          if (_.questaoSelecionada != null) {
            return ContainerQuestao(
              questao: _.questaoSelecionada!,
              numero: _.numeroQuestao,
            );
          } else {
            return Container();
          }
        }),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }
}
