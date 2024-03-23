import 'package:location/location.dart';
import 'package:flutter/material.dart';

class LocationService {
  Location location = Location();

  Future<bool> requestPermission() async {
    final permission = await location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled == false) {

      final result = await location.requestService();
      if (result) {
        debugPrint("Service has been enabled");
      } else {
        throw Exception("GPS service is not enabled");
      }
    }
    try {
      final locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
