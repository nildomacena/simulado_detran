import 'dart:math';

class UtilService {
  int gerarRandomQuestao() {
    var rng = Random();
    return rng.nextInt(1000000000);
  }

  String intParaLetra(int index) {
    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      default:
        return 'não encontrado';
    }
  }
}

UtilService utilService = UtilService();
