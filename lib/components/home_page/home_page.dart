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
          Positioned(
              bottom: 10,
              child: ElevatedButton(
                child: Text('Iniciar Questionário'),
                /*  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width * .5, 50)), */
                onPressed: () {
                  controller.irParaQuestionario();
                },
              ))
        ],
      ),
    );
  }
}
