// ignore_for_file: avoid_print

import 'package:location/location.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  LocationService._internal();
  factory LocationService() => _instance;

  final Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  bool get serviceEnabled => _serviceEnabled;
  PermissionStatus get permissionGranted => _permissionGranted;
  LocationData get locationData => _locationData;

  Future<void> initLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location permission denied.');
        return;
      }
    }

    _locationData = await location.getLocation();
    print('Location Data: $_locationData');
  }
}
