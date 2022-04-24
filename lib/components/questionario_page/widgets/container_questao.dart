import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/questionario_page/widgets/alternativa_container.dart';
import 'package:simulado_detran/util/util_service.dart';
import 'package:simulado_detran/model/alternativa_model.dart';
import 'package:simulado_detran/model/questao_model.dart';

class ContainerQuestao extends StatelessWidget {
  final Questao questao;
  final bool resposta;

  const ContainerQuestao(
      {required this.questao, this.resposta = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        children: [
          Card(
            child: Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 10),
                child: Text(
                  'asldfkçldsa' + questao.enunciado,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                )),
          ),
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
                    onPressed: () {
                      // _.selecionaAlternativa(alternativa);
                    });
              })
        ],
      ),
    );
  }
}
