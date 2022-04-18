import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_controller.dart';
import 'package:simulado_detran/components/questionario_page/questionario_repository.dart';

class QuestionarioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionarioController>(() => QuestionarioController(
        QuestionarioRepository(firestoreProvider: Get.find())));
  }
}
