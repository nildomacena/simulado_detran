import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_controller.dart';

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
          ListView(
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
                    'RESPONDER UMA QUESTÃO POR VEZ',
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
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 10,
              child: ElevatedButton(
                child: const Text('Iniciar Questionário'),
                /*  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width * .5, 50)), */
                onPressed: () {
                  controller.irParaSimulado();
                },
              ))
        ],
      ),
    );
  }
}
