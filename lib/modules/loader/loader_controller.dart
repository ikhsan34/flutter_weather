import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/modules/login/login_page.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class LoaderController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 1), () async {
      // if (checkCache()) {
      //   Get.offNamed(LoginPage.route);
      //   return;
      // }

      final LocationService locationService = LocationService();
      locationService.init();

      await locationService.locationData.first.then((locationData) {
        final box = GetStorage();
        final Coordinate coordinate = Coordinate(lat: locationData.latitude!, lon: locationData.longitude!);
        box.write('last_location', coordinate.toJson());
      });

      if (locationService.serviceEnabled && locationService.permissionGranted == PermissionStatus.granted) {
        Get.offNamed(LoginPage.route);
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

  bool checkCache() {
    final box = GetStorage();
    if (box.read('last_location') != null) {
      return true;
    }
    return false;
  }
}
