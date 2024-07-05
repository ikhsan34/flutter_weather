import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/services/api_service.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final LocationService _locationService = LocationService();

  WeatherModel? weather;
  List<WeatherModel> forecast = [];

  bool isLoading = false;

  @override
  void onReady() async {
    await getWeather();
    super.onReady();
  }

  Future<void> getWeather() async {
    setLoading(true);

    final api = APIService();
    final LocationData locationData = _locationService.locationData;
    weather = await api.getWeather(
      coordinate: Coordinate(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      ),
    );
    print('>>> Weather Data: $weather');
    print('>>> Datetime: ${weather!.dateTime}');

    forecast = await api.getWeatherForecast(
      coordinate: Coordinate(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      ),
    );

    for (var element in forecast) {
      print('>>> Forecast: ${element.dateTime}');
    }

    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
