import 'package:get/get.dart';
import 'package:simulado_detran/components/resultado_page/resultado_controller.dart';
import 'package:simulado_detran/components/resultado_page/resultado_repository.dart';

class ResultadoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultadoController>(() => ResultadoController(
        ResultadoRepository(firestoreProvider: Get.find())));
  }
}
