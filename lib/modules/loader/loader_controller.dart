import 'package:flutter_weather/modules/home/home_page.dart';
import 'package:get/get.dart';

class LoaderController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2), () {
      // Get.offNamed(HomePage.route);
    });
    super.onReady();
  }
}
