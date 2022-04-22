import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_repository.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:simulado_detran/routes/app_routes.dart';
import 'package:simulado_detran/util/util_service.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  final RxList<ResultadoQuestionario> _resultados =
      RxList<ResultadoQuestionario>();

  List<ResultadoQuestionario> get resultados => _resultados.toList();

  HomeController(this.repository) {
    _resultados.bindStream(repository.streamResultados());
    /* resultados.listen((resultados) {
      print('resultados: $resultados');
    }); */
  }

  irParaSimulado() {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': true, 'avulso': false});
  }

  irParaAvulso() {
    Get.toNamed(Routes.questionario,
        arguments: {'simulado': false, 'avulso': true});
  }
}
