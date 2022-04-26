import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simulado_detran/config/initial_binding.dart';
import 'package:simulado_detran/firebase_options.dart';
import 'package:simulado_detran/routes/app_pages.dart';
import 'package:simulado_detran/routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      initialRoute: Routes.splashscreen,
      getPages: AppPages.routes,
      title: 'Simulador Detran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
