import 'package:get/get.dart';
import 'package:simulado_detran/components/progresso_page/progresso_repository.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';

class ProgressoController extends GetxController {
  final RxList<ResultadoQuestionario> _resultados =
      RxList<ResultadoQuestionario>();

  List<ResultadoQuestionario> get resultados => _resultados.toList();

  final ProgressoRepository repository;
  ProgressoController(this.repository) {
    _resultados.bindStream(repository.streamResultados());
  }
}
