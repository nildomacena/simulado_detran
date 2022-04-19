import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/questionario_controller.dart';
import 'package:simulado_detran/model/alternativa_model.dart';

class AlternativaContainer extends StatelessWidget {
  final Alternativa alternativa;
  final Function? onPressed;
  final String letra;
  final QuestionarioController controller;
  final Color? backgroundColor;

  const AlternativaContainer(
      {required this.alternativa,
      required this.controller,
      required this.letra,
      required this.onPressed,
      this.backgroundColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionarioController>(builder: (_) {
      bool alternativaSelecionada = _.questaoAtual.resposta == alternativa;
      return Material(
        color: alternativaSelecionada
            ? Color.fromARGB(255, 209, 209, 209)
            : Colors.white,
        child: InkWell(
          onTap: () {
            if (onPressed != null) {
              onPressed!();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.bounceIn,
                child: alternativaSelecionada
                    ? const CircleAvatar(
                        child: Icon(Icons.check),
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
        ),
      );
    });
  }
}
