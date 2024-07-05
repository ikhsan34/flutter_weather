import 'package:flutter_weather/modules/home/home_binding.dart';
import 'package:flutter_weather/modules/home/home_page.dart';
import 'package:flutter_weather/modules/loader/loader_controller.dart';
import 'package:flutter_weather/modules/loader/loader_page.dart';
import 'package:flutter_weather/modules/login/login_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initial = HomePage.route;

  static final routes = [
    GetPage(
      name: LoaderPage.route,
      page: () => const LoaderPage(),
      binding: BindingsBuilder(() {
        Get.put(LoaderController());
      }),
    ),
    GetPage(
      name: HomePage.route,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: LoginPage.route,
      page: () => const LoginPage(),
    ),
  ];
}
