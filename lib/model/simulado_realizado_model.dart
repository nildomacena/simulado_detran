import 'package:simulado_detran/model/questao_model.dart';

class SimuladoRealizado {
  List<Questao> questionario;

  SimuladoRealizado(this.questionario);

  int get acertos =>
      questionario.where((q) => q.resposta == q.alternativaCorreta).length;
}
