import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/widgets/icone_menu_model.dart';

class IconeMenuContainer extends StatelessWidget {
  final IconeMenu icone;
  const IconeMenuContainer({required this.icone, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: icone.onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icone.imagem,
            Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                child: Text(
                  icone.titulo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
