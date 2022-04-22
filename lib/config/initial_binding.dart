import 'package:get/get.dart';
import 'package:simulado_detran/components/tabs_page/tabs_bindind.dart';
import 'package:simulado_detran/components/tabs_page/tabs_controller.dart';
import 'package:simulado_detran/data/firestore_provider.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FirestoreProvider(), permanent: true);
    /*  Get.put(TabsController(), permanent: true);
    Get.put(FirestoreProvider(), permanent: true); */
  }
}
