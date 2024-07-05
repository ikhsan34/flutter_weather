import 'package:flutter/material.dart';
import 'package:flutter_weather/modules/home/home_controller.dart';
import 'package:flutter_weather/modules/login/login_page.dart';
import 'package:flutter_weather/widgets/full_width_button.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  static const String route = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [
            FullWidthButton(
              onPressed: () {
                Get.offNamed(LoginPage.route);
              },
              label: 'Logout',
            )
          ],
        ));
  }
}
