import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

const int mesEmMilliseconds = 2592000000;

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

  int diasEmMilisseconds(int dias) {
    return dias * 24 * 60 * 60 * 1000;
  }

  bool checkValidadeAcesso(DateTime dataCadastro, int dias) {
    return dataCadastro.millisecondsSinceEpoch + diasEmMilisseconds(dias) <
        DateTime.now().millisecondsSinceEpoch;
  }

  void snackBarErro(
      {String? titulo,
      String? mensagem,
      bool embaixo = false,
      Duration? duration}) {
    Get.snackbar(
      titulo ?? 'Erro',
      mensagem ?? 'Erro durante a operação',
      snackPosition: embaixo ? SnackPosition.BOTTOM : SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
      duration: duration ?? const Duration(seconds: 5),
    );
  }

  void snackBar(
      {required String titulo,
      required String mensagem,
      SnackPosition? snackPosition,
      Function? action}) {
    Get.snackbar(
      titulo,
      mensagem,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: Colors.white,
      //colorText: Colors.white,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      duration: const Duration(seconds: 5),
    );
  }

  void showToast(String mensagem) {
    Fluttertoast.showToast(
      msg: mensagem,
      /* toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0 */
    );
  }
}

UtilService utilService = UtilService();
