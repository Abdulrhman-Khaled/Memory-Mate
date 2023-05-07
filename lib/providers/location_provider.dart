import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _currentLocation;
  final List<LatLng> _savedLocations = [];

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void saveLocation() {
    if (_currentLocation.toString().isNotEmpty) {
      _savedLocations.add(_currentLocation!);
      notifyListeners();
    }
  }

  LatLng? get currentLocation => _currentLocation;
  List<LatLng> get savedLocations => _savedLocations;
}