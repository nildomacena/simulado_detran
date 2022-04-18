import 'package:get/get.dart';
import 'package:simulado_detran/data/firestore_provider.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FirestoreProvider(), permanent: true);
  }
}
