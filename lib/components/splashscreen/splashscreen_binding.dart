import 'package:get/get.dart';
import 'package:simulado_detran/components/splashscreen/splashscreen_controller.dart';
import 'package:simulado_detran/components/splashscreen/splashscreen_respository.dart';

class SplashscreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenController>(() => SplashscreenController(
        SplashscreenRepository(firestoreProvider: Get.find())));
  }
}
