import 'package:flutter/material.dart';
import 'package:simulado_detran/model/questao_model.dart';
import 'package:simulado_detran/model/simulado_realizado_model.dart';

class GridQuestoes extends StatelessWidget {
  final SimuladoRealizado simuladoRealizado;
  const GridQuestoes({required this.simuladoRealizado, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: simuladoRealizado.questionario.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemBuilder: (context, index) {
          Questao questao = simuladoRealizado.questionario[index];

          return Container(
              decoration: BoxDecoration(
                  color: questao.acertou ? Colors.green : Colors.red),
              alignment: Alignment.center,
              child: Text(
                'Questão ${index + 1}',
                style: TextStyle(color: Colors.white),
              ));
        });
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
