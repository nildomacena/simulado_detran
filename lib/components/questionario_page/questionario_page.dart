import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_controller.dart';

class QuestionarioPage extends StatelessWidget {
  QuestionarioController controller = Get.find();
  QuestionarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
