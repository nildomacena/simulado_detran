import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_controller.dart';
import 'package:simulado_detran/model/alternativa_model.dart';

class AlternativaContainer extends StatelessWidget {
  final Alternativa alternativa;
  final Function? onPressed;
  final String letra;
  final QuestionarioController controller;
  final bool? correta;
  final bool? incorreta;

  const AlternativaContainer(
      {required this.alternativa,
      required this.controller,
      required this.letra,
      required this.onPressed,
      this.correta,
      this.incorreta,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionarioController>(builder: (_) {
      bool alternativaSelecionada = _.questaoAtual.resposta == alternativa;
      return Material(
        color: Colors.white,
        /*  color: correta != null && correta!
            ? Colors.green
            : incorreta != null && incorreta!
                ? Colors.red
                : Colors.white, */
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.bounceIn,
              child: incorreta != null && incorreta!
                  ? const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  : (correta != null && correta!) || alternativa.correta
                      ? const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          child: Text(letra),
                        ),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    alternativa.texto,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  )),
            )
          ]),
        ),
      );
    });
  }
}
