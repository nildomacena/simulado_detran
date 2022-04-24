import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:simulado_detran/components/home_page/home_page.dart';
import 'package:simulado_detran/components/progresso_page/progresso_page.dart';
import 'package:simulado_detran/components/tabs_page/tabs_controller.dart';

class TabsPage extends StatelessWidget {
  final TabsController controller = Get.find();
  TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    custombottomNavigationBar() {
      return GetBuilder<TabsController>(
          builder: (_) => SalomonBottomBar(
                  onTap: controller.changeTabIndex,
                  currentIndex: controller.tabIndex,
                  items: [
                    SalomonBottomBarItem(
                        icon: const Icon(LineIcons.check),
                        title: const Text("Questionário")),
                    SalomonBottomBarItem(
                        icon: const Icon(LineIcons.barChart),
                        title: const Text("Seu progresso")),
                    SalomonBottomBarItem(
                        icon: const Icon(LineIcons.barcode),
                        title: const Text("Ler Cód. de Barras")),
                    SalomonBottomBarItem(
                        icon: const Icon(LineIcons.gasPump),
                        title: const Text("Combustíveis")),
                    /*  SalomonBottomBarItem(
                      icon: const Icon(Icons.favorite),
                      title: const Text("Favoritos")), */
                  ]));
    }

    return Scaffold(
        body: Scaffold(
      body: GetBuilder<TabsController>(
          builder: (_) => IndexedStack(
                index: controller.tabIndex,
                children: [
                  HomePage(),
                  ProgressoPage(),
                  Container(color: Colors.red),
                  Container(color: Colors.blue),
                ],
              )),
      bottomNavigationBar: custombottomNavigationBar(),
    ));
  }
}
