import 'package:get/get.dart';

class TabsController extends GetxController {
  int tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    print('index: $index');

    update();
  }
}
