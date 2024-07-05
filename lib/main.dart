import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blueGrey),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
