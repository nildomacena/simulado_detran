import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/splashscreen/splashscreen_controller.dart';
import 'package:simulado_detran/widgets/loading_widget.dart';

class SplashscreenPage extends StatelessWidget {
  final SplashscreenController controller = Get.find();
  SplashscreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashscreenController>(
        builder: (_) {
          if (_.carregouBD == false && _.estaConectado == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_.estaConectado == false || true) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    child: const Text(
                      'Não foi detectada nenhuma conexão com a internet',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text('TENTAR NOVAMENTE'),
                      Icon(Icons.refresh)
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('NAVEGAR OFFLINE')),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
