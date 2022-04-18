import 'package:get/get.dart';
import 'package:simulado_detran/components/resultado_page/resultado_repository.dart';
import 'package:simulado_detran/model/simulado_realizado_model.dart';

class ResultadoController extends GetxController {
  late SimuladoRealizado simuladoRealizado;
  final ResultadoRepository repository;
  ResultadoController(this.repository);
  @override
  void onInit() {
    simuladoRealizado = Get.arguments;
    print('arguments: ${Get.arguments}');
    super.onInit();
  }
}
