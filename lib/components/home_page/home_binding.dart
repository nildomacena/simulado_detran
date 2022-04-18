import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_controller.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(HomeRepository(firestoreProvider: Get.find())));
  }
}
