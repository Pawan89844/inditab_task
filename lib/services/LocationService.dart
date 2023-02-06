// ignore_for_file: file_names
// import 'package:location/location.dart' as location;

import 'package:location/location.dart';

class LocationService {
  Future<bool> _serviceEnabled(Location location) async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    return serviceEnabled;
  }

  Future<PermissionStatus> _checkPermission(Location location) async {
    PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    return permissionGranted;
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    _checkPermission(location);
    _serviceEnabled(location);
    return location.getLocation();
  }
}
