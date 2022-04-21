import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController(this.repository);

  irParaSimulado() {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': true, 'avulso': false});
  }

  irParaAvulso() {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': false, 'avulso': true});
  }
}
