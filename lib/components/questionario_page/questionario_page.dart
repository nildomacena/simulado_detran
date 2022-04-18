import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_controller.dart';

class QuestionarioPage extends StatelessWidget {
  QuestionarioController controller = Get.find();
  QuestionarioPage({Key? key}) : super(key: key);

  Widget titulo = GetBuilder<QuestionarioController>(
      builder: (_) => _.carregando
          ? const Text('Carregando questionário...')
          : Text('Questão ${_.numQuestaoAtual}'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: titulo),
      body: Container(
        alignment: Alignment.center,
        child: GetBuilder<QuestionarioController>(
          builder: (_) {
            if (_.carregando) {
              return const CircularProgressIndicator();
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(_.questaoAtual.enunciado)],
                ),
                if (!_.ultimaQuestao)
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: FloatingActionButton(
                        child: const Icon(Icons.arrow_right),
                        onPressed: () {
                          _.avancarQuestao();
                        },
                      )),
                if (!_.primeiraQuestao)
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: FloatingActionButton(
                        child: const Icon(Icons.arrow_left),
                        onPressed: () {
                          _.retrocederQuestao();
                        },
                      )),
              ],
            );
          },
        ),
      ),
    );
  }
}
