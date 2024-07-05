import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String? icon;
  const WeatherIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return const Icon(Icons.error_outline);
    }

    return CachedNetworkImage(imageUrl: 'https://openweathermap.org/img/wn/${ParseIcon.getIcon(icon!)}@4x.png');
  }
}

class ParseIcon {
  static String getIcon(String icon) {
    switch (icon) {
      case '01d':
        return '02d';
      case '01n':
        return '02n';
      case '02d':
        return '02d';
      case '02n':
        return '02n';
      case '03d':
        return '03d';
      case '03n':
        return '03n';
      case '04d':
        return '04d';
      case '04n':
        return '04n';
      case '09d':
        return '09d';
      case '09n':
        return '09n';
      case '10d':
        return '10d';
      case '10n':
        return '10n';
      case '11d':
        return '11d';
      case '11n':
        return '11n';
      case '13d':
        return '13d';
      case '13n':
        return '13n';
      case '50d':
        return '50d';
      case '50n':
        return '50n';
      default:
        return '02d';
    }
  }
}
