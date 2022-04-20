import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_controller.dart';
import 'package:simulado_detran/components/questionario_page/widgets/alternativa_container.dart';
import 'package:simulado_detran/util/util_service.dart';
import 'package:simulado_detran/model/alternativa_model.dart';

class QuestionarioPage extends StatelessWidget {
  final QuestionarioController controller = Get.find();
  QuestionarioPage({Key? key}) : super(key: key);

  final Widget titulo = GetBuilder<QuestionarioController>(
      builder: (_) => _.carregando
          ? const Text('Carregando questionário...')
          : Text('Questão ${_.numQuestaoAtual}'));
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.confirmaWillPop,
      child: Scaffold(
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
                  ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 10),
                          child: Text(
                            _.questaoAtual.enunciado,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 18),
                          )),
                      if (_.questaoAtual.imagem != null &&
                          _.questaoAtual.imagem!.isNotEmpty)
                        SizedBox(
                            height: 100,
                            child: Image.network(_.questaoAtual.imagem!)),
                      const Divider(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            Alternativa alternativa =
                                _.questaoAtual.alternativas[index];
                            return AlternativaContainer(
                                alternativa: alternativa,
                                controller: Get.find(),
                                letra: utilService.intParaLetra(index),
                                onPressed: () {
                                  _.selecionaAlternativa(alternativa);
                                });
                          })
                    ],
                  ),
                  Positioned(
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: Get.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!_.primeiraQuestao)
                              FloatingActionButton(
                                heroTag: 'btnVoltar',
                                child: const Icon(Icons.arrow_left),
                                onPressed: () {
                                  _.retrocederQuestao();
                                },
                              ),
                            Expanded(
                                child: Container(
                              height: 55,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                child: const Text('FINALIZAR SIMULADO'),
                                onPressed: () {
                                  _.finalizarQuestionario();
                                },
                              ),
                            )),
                            if (!_.ultimaQuestao &&
                                _.questaoAtual.resposta == null)
                              FloatingActionButton(
                                heroTag: 'btnAvancar',
                                child: const Icon(Icons.arrow_right),
                                onPressed: () {
                                  _.avancarQuestao();
                                },
                              ),
                            if (_.questaoAtual.resposta != null)
                              FloatingActionButton(
                                heroTag: 'btnResponder',
                                child: const Icon(Icons.check),
                                onPressed: () {
                                  _.responderQuestao();
                                },
                              ),
                          ],
                        ),
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
