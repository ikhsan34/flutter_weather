import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/services/api_service.dart';
import 'package:flutter_weather/services/location_service.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final LocationService _locationService = LocationService();

  @override
  void onReady() async {
    // await getWeather();
    super.onReady();
  }

  Future<void> getWeather() async {
    final api = APIService();
    final LocationData locationData = _locationService.locationData;
    WeatherModel? weather = await api.getWeather(
      coordinate: Coordinate(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      ),
    );
    print('>>> Location Data: ${_locationService.locationData}');
    print('>>> Weather Data: $weather');
    print('>>> Datetime: ${weather!.dateTime}');

    List<WeatherModel> forecast = await api.getWeatherForecast(
      coordinate: Coordinate(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      ),
    );

    for (var element in forecast) {
      print('>>> Forecast: ${element.dateTime}');
    }
  }
}
