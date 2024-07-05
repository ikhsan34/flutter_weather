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
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
