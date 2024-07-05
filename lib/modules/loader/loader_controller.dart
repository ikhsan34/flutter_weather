import 'package:flutter/material.dart';
import 'package:flutter_weather/modules/home/home_page.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LoaderController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2), () async {
      final LocationService locationService = LocationService();
      await locationService.initLocationService();
      if (locationService.serviceEnabled && locationService.permissionGranted == PermissionStatus.granted) {
        Get.offNamed(HomePage.route);
      } else {
        Get.snackbar(
          'Error',
          'Location service is not enabled or permission denied.',
          backgroundColor: const Color(0xFFD32F2F),
          colorText: const Color(0xFFFFFFFF),
        );
      }
    });
    super.onReady();
  }
}
