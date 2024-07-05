import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late final TextEditingController _controller;

  final places = FlutterGooglePlacesSdk(dotenv.env['GMAPS_KEY']!);
  FindAutocompletePredictionsResponse predictions = const FindAutocompletePredictionsResponse([]);

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            onChanged: (value) async {
              await places.findAutocompletePredictions(value).then((result) {
                setState(() {
                  predictions = result;
                });
              });
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search location',
              border: OutlineInputBorder(),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: predictions.predictions.length,
            itemBuilder: (context, index) {
              final AutocompletePrediction item = predictions.predictions[index];
              return ListTile(
                title: Text(item.primaryText),
                subtitle: Text(item.secondaryText),
                onTap: () async {
                  await places.fetchPlace(item.placeId, fields: [PlaceField.Location]).then((value) {
                    final LatLng? location = value.place?.latLng;
                    if (location != null) {
                      Get.back(result: Coordinate(lon: location.lng, lat: location.lat));
                    }
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
