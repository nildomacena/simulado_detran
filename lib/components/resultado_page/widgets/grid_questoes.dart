import 'package:flutter/material.dart';
import 'package:simulado_detran/components/resultado_page/resultado_controller.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/simulado_realizado_model.dart';

class GridQuestoes extends StatelessWidget {
  final SimuladoRealizado simuladoRealizado;
  final ResultadoController controller;
  const GridQuestoes(
      {required this.simuladoRealizado, required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
          itemCount: simuladoRealizado.questionario.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
          itemBuilder: (context, index) {
            Questao questao = simuladoRealizado.questionario[index];

            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: questao.acertou ? Colors.green : Colors.red),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    controller.selecionarQuestao(questao);
                    print('Questao: $questao');
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Questão ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
              ),
            );
          }),
    );
    /* return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: simuladoRealizado.questionario
          .map((e) => const Text('Teste'))
          .toList(),
    ); */
  }
}
