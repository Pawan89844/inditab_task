// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:task_inditab/api/API.dart';
import 'package:task_inditab/models/RestrauntModel.dart';
import 'package:task_inditab/screens/home/map.dart';
import 'package:task_inditab/screens/profile/profile.dart';
import 'package:task_inditab/services/LocationService.dart';
import 'package:task_inditab/services/LocationStream.dart';
import 'package:task_inditab/services/PaymentService.dart';
import 'package:task_inditab/utils/AppText.dart';
import 'package:rxdart/rxdart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PaymentService _service = PaymentService();
  LocationService locationService = LocationService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Location _location = Location();
  final PlacesAPI _api = PlacesAPI();

  @override
  void initState() {
    super.initState();
    // locationService.getCurrentLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _service.razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) =>
            _service.handlePaymentSuccess(response, context));
    _service.razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) =>
            _service.handlePaymentError(response, context));
  }

  FutureBuilder _getRestraunt(AsyncSnapshot<LocationData> snapshot) {
    return FutureBuilder<RestrauntModel>(
      future: _api.getRestraunts(snapshot.data!.latitude.toString(),
          snapshot.data?.longitude.toString()),
      builder: (context, AsyncSnapshot<RestrauntModel> snap) {
        if (snap.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snap.data!.features.isEmpty) {
            return Center(
              child: Utils.appText('No Restraunt found in your area'),
            );
          } else {
            List<Features> features = snap.data?.features ?? <Features>[];
            return SingleChildScrollView(
              child: Column(
                children: features.map((res) {
                  print('snapshot data:- ${snap.data}');
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RestrauntOnMap(
                                  lat: res.properties.lat,
                                  lng: res.properties.lon,
                                  restrauntName: res.properties.name),
                            )),
                        title: Utils.appText(res.properties.name),
                        subtitle: Text('Address: ${res.properties.formatted}'),
                        trailing: IconButton(
                            onPressed: () => _service.openCheckout(
                                10000,
                                res.properties.name,
                                _auth.currentUser?.phoneNumber ?? '',
                                _auth.currentUser?.email ?? '',
                                _auth.currentUser?.displayName ?? ''),
                            icon: const Icon(Icons.shopping_cart_outlined))),
                  );
                }).toList(),
              ),
            );
            //  ListView.builder(
            //   itemCount: snap.data?.features.length,
            //   itemBuilder: (context, i) {

            //   },
            // );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Utils.appText(
              'Welcome ${FirebaseAuth.instance.currentUser?.displayName ?? ''}',
              color: Colors.black,
              fontWeight: FontWeight.bold),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const Profile(),
                    )),
                icon: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    // color: Colors.black,
                  ),
                )),
            const SizedBox(width: 20.0),
          ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {}),
          child: const Icon(Icons.location_pin)),
      body: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: FutureBuilder<LocationData>(
              future: locationService.getCurrentLocation(),
              builder: (context, AsyncSnapshot<LocationData> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Utils.appText(
                        'Oops unable to detect your location\nPlease click fetch my location button on the bottom right to fetch nearby restruants'),
                  ));
                } else {
                  if (snapshot.data?.latitude == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return _getRestraunt(snapshot);
                  }
                }
              })),
    );
  }
}
