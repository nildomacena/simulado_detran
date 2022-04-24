import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_controller.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:simulado_detran/components/home_page/widgets/icone_menu_container.dart';
import 'package:simulado_detran/components/home_page/widgets/icone_menu_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shrinkWrap: true,
            children: controller
                .generateMenuItens()
                .map((i) => IconeMenuContainer(
                      icone: i,
                    ))
                .toList(),
          ),
          /* ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: Get.width,
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'FAZER SIMULADO TRADICIONAL',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {
                    controller.irParaSimulado();
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: Get.width,
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'RESPONDER QUESTÕES AVULSAS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {
                    controller.irParaAvulso();
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: Get.width,
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'VER HISTÓRICO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {},
                ),
              ),
            ],
          ), */
          /*  Positioned(
              bottom: 10,
              child: ElevatedButton(
                child: const Text('Iniciar Questionário'),
                /*  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width * .5, 50)), */
                onPressed: () {
                  controller.irParaSimulado();
                },
              )) */
        ],
      ),
    );
  }
}
