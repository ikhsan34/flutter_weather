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

  Future<void> getWeather({Coordinate? coordinate}) async {
    setLoading(true);

    final api = APIService();
    final LocationData locationData = _locationService.locationData;
    weather = await api.getWeather(
      coordinate: Coordinate(
        lat: coordinate?.lat ?? locationData.latitude!,
        lon: coordinate?.lon ?? locationData.longitude!,
      ),
    );

    forecast = await api.getWeatherForecast(
      coordinate: Coordinate(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      ),
    );

    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
