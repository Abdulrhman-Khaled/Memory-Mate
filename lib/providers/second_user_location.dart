import 'package:flutter/material.dart';

class SecondUserLocation {
  final double latitude;
  final double longitude;

  SecondUserLocation({required this.latitude, required this.longitude});
}

class SecondUserLocationProvider extends ChangeNotifier {
  SecondUserLocation _location = SecondUserLocation(latitude: 0.0, longitude: 0.0);

  SecondUserLocation get location => _location;

  void setLocation(double latitude, double longitude) {
    _location = SecondUserLocation(latitude: latitude, longitude: longitude);
    notifyListeners();
  }
}