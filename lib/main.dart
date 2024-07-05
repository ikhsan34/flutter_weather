import 'package:flutter/material.dart';
import 'package:flutter_weather/routes/app_routes.dart';
import 'package:get/get.dart';

void main() {
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
