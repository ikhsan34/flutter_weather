// ignore_for_file: avoid_print

import 'package:flutter_weather/models/weather_model.dart';
import 'package:get_storage/get_storage.dart';
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
    writeCache();

    print('Location Data: $_locationData');
  }

  Future<void> writeCache() async {
    final box = GetStorage();
    final Coordinate coordinate = Coordinate(
      lat: _locationData.latitude!,
      lon: _locationData.longitude!,
    );

    box.write('last_location', coordinate.toJson());
    box.write('location_timestamp', DateTime.now().millisecondsSinceEpoch);
  }
}
