import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_controller.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';
import 'package:simulado_detran/components/progresso_page/progresso_controller.dart';
import 'package:simulado_detran/components/progresso_page/progresso_repository.dart';
import 'package:simulado_detran/components/tabs_page/tabs_controller.dart';

class TabsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(() => TabsController());
    Get.lazyPut<HomeController>(
        () => HomeController(HomeRepository(firestoreProvider: Get.find())),
        fenix: true);
    Get.lazyPut<ProgressoController>(
        () => ProgressoController(
            ProgressoRepository(firestoreProvider: Get.find())),
        fenix: true);
  }
}
