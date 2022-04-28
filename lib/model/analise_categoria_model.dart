import 'package:simulado_detran/model/categoria_model.dart';

class AnaliseCategoria {
  final Categoria categoria;
  final num questoesRespondidas;
  final num acertos;

  AnaliseCategoria(
      {required this.categoria,
      required this.questoesRespondidas,
      required this.acertos});

  double get porcentagemAcertos =>
      questoesRespondidas == 0 ? 0 : acertos / questoesRespondidas;
}
