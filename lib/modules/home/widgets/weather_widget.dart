import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/modules/home/home_controller.dart';
import 'package:flutter_weather/modules/home/widgets/search_widget.dart';
import 'package:flutter_weather/modules/home/widgets/weather_icon.dart';
import 'package:flutter_weather/modules/login/login_page.dart';
import 'package:flutter_weather/widgets/full_width_button.dart';
import 'package:get/get.dart';

class WeatherWidget extends GetView<HomeController> {
  const WeatherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WeatherModel? weather = controller.weather;
    List<WeatherModel> forecast = controller.forecast;

    return Column(
      children: [
        const Spacer(),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.getWeather();
                },
                icon: const Icon(
                  Icons.refresh_outlined,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              IconButton(
                // onPressed: () async {
                //   final places = FlutterGooglePlacesSdk('AIzaSyAk9V4IpcLoliJTtKyhb5nSnS5EWcKarsE');
                //   final predictions = await places.findAutocompletePredictions('Bandung');
                //   print('Result: $predictions');

                //   final getLocation = await places.fetchPlace('ChIJf0dSgjnmaC4RshXo05MfahQ', fields: [PlaceField.Location]);
                //   print('Location: ${getLocation.place?.latLng}');
                // },
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return const SearchWidget();
                    },
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Text(
          weather?.name ?? 'Unknown',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Humidity: ${weather?.main.humidity}%',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Colors.white, Color(0xFF3D808A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Text(
                '${weather?.main.temp.toInt()}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 62,
                ),
              ),
            ),
            WeatherIcon(icon: weather?.weather[0].icon ?? ''),
          ],
        ),
        const SizedBox(height: 50),
        SizedBox(
          height: 180,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: forecast.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2 / 1,
                ),
                itemBuilder: (context, index) {
                  WeatherModel item = forecast[index];
                  return Column(
                    children: [
                      WeatherIcon(icon: item.weather[0].icon),
                      Text(
                        '${item.dateTime.hour}:00',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        '${item.main.temp.toInt()}°C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: FullWidthButton(
            onPressed: () {
              Get.offNamed(LoginPage.route);
            },
            label: 'Logout',
          ),
        )
      ],
    );
  }
}
