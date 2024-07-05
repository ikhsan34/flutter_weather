class WeatherModel {
  final int? id;
  final int? timezone;
  final String? name;
  final DateTime dateTime;

  final Coordinate? coord;
  final List<Weather> weather;
  final WeatherData main;

  const WeatherModel({
    required this.id,
    required this.timezone,
    required this.name,
    required this.coord,
    required this.weather,
    required this.main,
    required this.dateTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'],
      timezone: json['timezone'],
      name: json['name'],
      coord: json['coord'] != null ? Coordinate.fromJson(json['coord']) : null,
      weather: (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
      main: WeatherData.fromJson(json['main']),
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000), // Epoch time in seconds
    );
  }
}

class Coordinate {
  final double lon;
  final double lat;

  const Coordinate({required this.lon, required this.lat});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class WeatherData {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  const WeatherData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }
}
