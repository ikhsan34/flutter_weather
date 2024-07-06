import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/modules/login/login_page.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class LoaderController extends GetxController {
  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 1));

    final LocationService locationService = LocationService();
    locationService.init();

    while (locationService.permissionGranted == null) {
      print('Waiting for initializing...');
      await Future.delayed(const Duration(milliseconds: 500));
    }

    while (locationService.permissionGranted != PermissionStatus.granted) {
      print('Waiting for location permission...');

      await Future.delayed(const Duration(seconds: 1));
      await showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text('Location Permission'),
            content: const Text('Please allow location permission to continue.'),
            actions: [
              TextButton(
                onPressed: () async {
                  await AppSettings.openAppSettings(type: AppSettingsType.location);

                  await Future.delayed(const Duration(seconds: 3));

                  while (Get.engine.lifecycleState != AppLifecycleState.resumed) {
                    print('AppState: ${Get.engine.lifecycleState}');
                    await Future.delayed(const Duration(milliseconds: 500));
                  }

                  Get.back();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      locationService.permissionGranted = null;
      locationService.requestPermission();
      while (locationService.permissionGranted == null) {
        print('Waiting for reinitializing...');
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    if (locationService.serviceEnabled && locationService.permissionGranted == PermissionStatus.granted) {
      if (!checkCache()) {
        locationService.getLocation();
        locationService.locationData.first.then((locationData) {
          Get.offNamed(LoginPage.route);
        });
        return;
      }

      Get.offNamed(LoginPage.route);
    } else {
      Get.snackbar(
        'Error',
        'Location service is not enabled or permission denied.',
        backgroundColor: const Color(0xFFD32F2F),
        colorText: const Color(0xFFFFFFFF),
      );
    }
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
