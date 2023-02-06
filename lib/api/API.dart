// ignore_for_file: file_names, avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/RestrauntModel.dart';

class PlacesAPI {
  final String _apiKey = "1a7c08f97400477eaf791b8c737761bc";
  final String _apiUrl =
      "https://api.geoapify.com/v2/places?categories=catering.restaurant&filter=circle:";

  Future<RestrauntModel> getRestraunts(String lat, lng) async {
    // ignore: prefer_interpolation_to_compose_strings
    final String url =
        'https://api.geoapify.com/v2/places?categories=catering.restaurant&filter=circle:$lng,$lat,10000&bias=proximity:$lng,$lat&limit=20&apiKey=$_apiKey';
    print('Url:- $url');
    http.Response req = await http.get(Uri.parse(url));
    var response = jsonDecode(req.body);
    return RestrauntModel.fromJson(response);
  }
}
