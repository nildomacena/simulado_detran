import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_binding.dart';
import 'package:simulado_detran/components/home_page/home_page.dart';
import 'package:simulado_detran/components/login_page/login_binding.dart';
import 'package:simulado_detran/components/login_page/login_page.dart';
import 'package:simulado_detran/components/questionario_page/questionario_binding.dart';
import 'package:simulado_detran/components/questionario_page/questionario_page.dart';
import 'package:simulado_detran/components/resultado_page/resultado_binding.dart';
import 'package:simulado_detran/components/resultado_page/resultado_page.dart';
import 'package:simulado_detran/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.questionario,
        page: () => QuestionarioPage(),
        binding: QuestionarioBinding()),
    GetPage(
        name: Routes.resultado,
        page: () => ResultadoPage(),
        binding: ResultadoBinding()),
  ];
}
