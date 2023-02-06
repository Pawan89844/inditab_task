import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestrauntOnMap extends StatefulWidget {
  final double lat;
  final double lng;
  final String restrauntName;
  const RestrauntOnMap(
      {super.key,
      required this.lat,
      required this.lng,
      required this.restrauntName});

  @override
  State<RestrauntOnMap> createState() => _RestrauntOnMapState();
}

class _RestrauntOnMapState extends State<RestrauntOnMap> {
  final Set<Marker> _marker = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lng),
      zoom: 14.4746,
    );
    _marker.add(Marker(
        markerId: const MarkerId('current_Postion'),
        infoWindow: InfoWindow(title: widget.restrauntName),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        )));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: _marker,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
