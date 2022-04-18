import 'dart:math';

class UtilService {
  int gerarRandomQuestao() {
    var rng = Random();
    return rng.nextInt(1000000000);
  }
}

UtilService utilService = UtilService();
