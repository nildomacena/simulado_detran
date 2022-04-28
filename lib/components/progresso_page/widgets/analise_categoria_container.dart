import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simulado_detran/model/analise_categoria_model.dart';

class AnaliseCategoriaContainer extends StatelessWidget {
  final AnaliseCategoria analiseCategoria;
  const AnaliseCategoriaContainer(this.analiseCategoria, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              analiseCategoria.categoria.nome,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Text(
                  'Questões respondidas: ${analiseCategoria.questoesRespondidas}'),
              Expanded(child: Container()),
              Text('Total acertos: ${analiseCategoria.acertos}')
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: LinearPercentIndicator(
              //width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 800,
              percent: analiseCategoria.porcentagemAcertos,
              center: Text(
                '${analiseCategoria.porcentagemAcertos == 0 ? 0 : (analiseCategoria.porcentagemAcertos * 100).toPrecision(1)}%',
                style: TextStyle(color: Colors.white),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: analiseCategoria.porcentagemAcertos >= 0.7
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
