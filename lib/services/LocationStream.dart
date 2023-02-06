// ignore_for_file: file_names

import 'package:location/location.dart';

class LocationStream {
  final bool isEnabled;
  final PermissionStatus permissionStatus;
  final LocationData location;

  LocationStream(this.isEnabled, this.permissionStatus, this.location);
}
