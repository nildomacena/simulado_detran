import 'package:get/get.dart';
import 'package:simulado_detran/components/progresso_page/progresso_repository.dart';
import 'package:simulado_detran/model/analise_categoria_model.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';

class ProgressoController extends GetxController {
  final RxList<ResultadoQuestionario> _resultados =
      RxList<ResultadoQuestionario>();
  List<AnaliseCategoria>? analiseCategoria;
  List<ResultadoQuestionario> get resultados => _resultados.toList();

  final ProgressoRepository repository;
  ProgressoController(this.repository) {
    _resultados.bindStream(repository.streamResultados());
  }

  @override
  void onInit() async {
    super.onInit();
    repository.getAnaliseCategorias().then((value) {
      print('value: $value');
    });
  }
}
