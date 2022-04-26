import 'package:get/get.dart';
import 'package:simulado_detran/components/splashscreen/splashscreen_respository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class SplashscreenController extends GetxController {
  final SplashscreenRepository repository;
  bool carregouBD = false;
  bool? estaConectado;

  SplashscreenController(this.repository);

  @override
  void onInit() async {
    await checaConnectivity();
    repository.checaVersaoBancoDeDados().then((value) {
      carregouBD = true;
      if (estaConectado ?? false) {
        irParaHome();
      }
      update();
    });
    super.onInit();
  }

  checaConnectivity([bool? novaTentativa]) async {
    if (novaTentativa ?? false) {
      estaConectado = null;
    }
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      estaConectado = false;
      update();
    } else {
      estaConectado = true;
      update();
    }
  }

  irParaHome() {
    Get.offAllNamed(Routes.tabs);
  }
}
