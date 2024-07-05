import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/services/api_service.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final LocationService _locationService = LocationService();

  WeatherModel? weather;
  List<WeatherModel> forecast = [];

  late Coordinate currentLocation;

  bool isLoading = false;

  @override
  void onReady() async {
    _locationService.locationData.listen((event) {
      currentLocation = Coordinate(lat: event.latitude!, lon: event.longitude!);
    });
    await checkLocationCache();
    super.onReady();
  }

  Future<void> checkLocationCache() async {
    final box = GetStorage();
    if (box.read('last_location') != null && !isCacheExpired()) {
      final Coordinate lastLocation = Coordinate.fromJson(box.read('last_location'));
      await getWeather(coordinate: lastLocation);
      _locationService.init();
      return;
    }

    setLoading(true);
    _locationService.init();
    await getWeather();
  }

  Future<void> getWeather({Coordinate? coordinate}) async {
    setLoading(true);

    final api = APIService();
    weather = await api.getWeather(
      coordinate: Coordinate(
        lat: coordinate?.lat ?? currentLocation.lat,
        lon: coordinate?.lon ?? currentLocation.lon,
      ),
    );

    forecast = await api.getWeatherForecast(
      coordinate: Coordinate(
        lat: coordinate?.lat ?? currentLocation.lat,
        lon: coordinate?.lon ?? currentLocation.lon,
      ),
    );

    _locationService.getLocation();
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  bool isCacheExpired() {
    final box = GetStorage();
    if (box.read('location_timestamp') == null) return true;
    final DateTime cachedTime = DateTime.fromMillisecondsSinceEpoch(box.read('location_timestamp'));
    return DateTime.now().difference(cachedTime) > const Duration(minutes: 15);
  }
}
