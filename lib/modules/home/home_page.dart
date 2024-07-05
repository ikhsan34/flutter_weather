import 'package:flutter/material.dart';
import 'package:flutter_weather/modules/home/home_controller.dart';
import 'package:flutter_weather/modules/home/widgets/weather_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D808A),
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.isLoading) {
              if (controller.isCacheExpired()) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Getting your location, might take a while...',
                        style: TextStyle(color: Colors.white),
                      ),
                      LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.white70,
                      )
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white70,
                ),
              );
            }

            return const WeatherWidget();
          },
        ),
      ),
    );
  }
}
