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
      backgroundColor: const Color(0xFF3D808A),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Kota Bandung',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Humidity: 80%',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Colors.white, Color(0xFF3D808A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: const Text(
                    '30°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 62,
                    ),
                  ),
                ),
                const Image(image: NetworkImage('https://openweathermap.org/img/wn/10d@4x.png')),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 180,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,
                      childAspectRatio: 2 / 1,
                    ),
                    itemBuilder: (context, index) {
                      return const Column(
                        children: [
                          Image(
                            image: NetworkImage('https://openweathermap.org/img/wn/10d@2x.png'),
                          ),
                          Text(
                            '2:00 AM',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '32°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FullWidthButton(
                onPressed: () {
                  Get.offNamed(LoginPage.route);
                },
                label: 'Logout',
              ),
            )
          ],
        ),
      ),
    );
  }
}
