import 'package:get/get.dart';
import 'package:simulado_detran/components/progresso_page/progresso_controller.dart';
import 'package:simulado_detran/components/progresso_page/progresso_repository.dart';

class ProgressoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressoController>(
        () => ProgressoController(
            ProgressoRepository(firestoreProvider: Get.find())),
        fenix: true);
  }
}
