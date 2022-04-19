import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/resultado_page/widgets/alternativa_container.dart';
import 'package:simulado_detran/components/util/util_service.dart';
import 'package:simulado_detran/model/alternativa_model.dart';
import 'package:simulado_detran/model/questao_model.dart';

class ContainerQuestao extends StatelessWidget {
  final Questao questao;
  final bool resposta;
  final String numero;

  const ContainerQuestao(
      {required this.questao,
      this.resposta = false,
      required this.numero,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          width: Get.width,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Questão $numero',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: questao.resposta == null
                        ? Colors.grey
                        : questao.acertou
                            ? Colors.green
                            : Colors.red),
              ),
              Container(
                  child: questao.resposta == null
                      ? const Icon(
                          Icons.remove_circle,
                          color: Colors.grey,
                        )
                      : questao.acertou
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            ))
            ],
          ),
        ),
        Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: Text(
              questao.enunciado,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 18),
            )),
        if (questao.imagem != null && questao.imagem!.isNotEmpty)
          SizedBox(height: 100, child: Image.network(questao.imagem!)),
        const Divider(),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              Alternativa alternativa = questao.alternativas[index];
              return AlternativaContainer(
                  alternativa: alternativa,
                  controller: Get.find(),
                  letra: utilService.intParaLetra(index),
                  correta: questao.resposta == alternativa && questao.acertou,
                  incorreta:
                      questao.resposta == alternativa && !questao.acertou,
                  onPressed: null);
            })
      ],
    );
  }
}
