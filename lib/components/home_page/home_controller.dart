import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController(this.repository);

  irParaQuestionario() {
    Get.toNamed(Routes.questionario);
  }
}
