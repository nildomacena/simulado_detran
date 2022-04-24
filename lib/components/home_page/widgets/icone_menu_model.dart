import 'package:flutter/cupertino.dart';

class IconeMenu {
  String titulo;
  Widget imagem;
  void Function() onPressed;

  IconeMenu(
      {required this.titulo, required this.imagem, required this.onPressed});
}
