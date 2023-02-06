// ignore_for_file: file_names

class RestrauntModel {
  RestrauntModel({
    required this.type,
    required this.features,
  });
  late final String type;
  late final List<Features> features;

  RestrauntModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    features =
        List.from(json['features']).map((e) => Features.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['features'] = features.map((e) => e.toJson()).toList();
    return data;
  }
}

class Features {
  Features({
    required this.type,
    required this.properties,
    required this.geometry,
  });
  late final String type;
  late final Properties properties;
  late final Geometry geometry;

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = Properties.fromJson(json['properties']);
    geometry = Geometry.fromJson(json['geometry']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['properties'] = properties.toJson();
    data['geometry'] = geometry.toJson();
    return data;
  }
}

class Properties {
  Properties({
    required this.name,
    required this.country,
    required this.countryCode,
    required this.state,
    required this.stateDistrict,
    required this.county,
    required this.postcode,
    required this.street,
    required this.housenumber,
    required this.lon,
    required this.lat,
    required this.stateCode,
    required this.formatted,
    required this.addressLine1,
    required this.addressLine2,
    required this.categories,
    required this.details,
    required this.datasource,
    required this.distance,
    required this.placeId,
  });
  late final String name;
  late final String country;
  late final String countryCode;
  late final String state;
  late final String stateDistrict;
  late final String county;
  late final String postcode;
  late final String street;
  late final String housenumber;
  late final double lon;
  late final double lat;
  late final String stateCode;
  late final String formatted;
  late final String addressLine1;
  late final String addressLine2;
  late final List<String> categories;
  late final List<String> details;
  late final Datasource datasource;
  late final int distance;
  late final String placeId;

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    country = json['country'] ?? '';
    countryCode = json['country_code'] ?? '';
    state = json['state'] ?? '';
    stateDistrict = json['state_district'] ?? '';
    county = json['county'] ?? '';
    postcode = json['postcode'] ?? '';
    street = json['street'] ?? '';
    housenumber = json['housenumber'] ?? '';
    lon = json['lon'] ?? 0.0;
    lat = json['lat'] ?? 0.0;
    stateCode = json['state_code'] ?? '';
    formatted = json['formatted'] ?? '';
    addressLine1 = json['address_line1'] ?? '';
    addressLine2 = json['address_line2'] ?? '';
    categories = List.castFrom<dynamic, String>(json['categories']);
    details = List.castFrom<dynamic, String>(json['details']);
    datasource = Datasource.fromJson(json['datasource']);
    distance = json['distance'] ?? '';
    placeId = json['place_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['state'] = state;
    data['state_district'] = stateDistrict;
    data['county'] = county;
    data['postcode'] = postcode;
    data['street'] = street;
    data['housenumber'] = housenumber;
    data['lon'] = lon;
    data['lat'] = lat;
    data['state_code'] = stateCode;
    data['formatted'] = formatted;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['categories'] = categories;
    data['details'] = details;
    data['datasource'] = datasource.toJson();
    data['distance'] = distance;
    data['place_id'] = placeId;
    return data;
  }
}

class Datasource {
  Datasource({
    required this.sourcename,
    required this.attribution,
    required this.license,
    required this.url,
    required this.raw,
  });
  late final String sourcename;
  late final String attribution;
  late final String license;
  late final String url;
  late final Raw raw;

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
    raw = Raw.fromJson(json['raw']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sourcename'] = sourcename;
    data['attribution'] = attribution;
    data['license'] = license;
    data['url'] = url;
    data['raw'] = raw.toJson();
    return data;
  }
}

class Raw {
  Raw({
    required this.bar,
    required this.name,
    required this.phone,
    required this.osmId,
    required this.amenity,
    required this.cuisine,
    required this.smoking,
    required this.website,
    required this.building,
    required this.osmType,
    required this.addrcity,
    required this.addrstreet,
    required this.addrpostcode,
    required this.openingHours,
    required this.brandwikidata,
    required this.brandwikipedia,
    required this.addrhousenumber,
    required this.airConditioning,
  });
  late final String bar;
  late final String name;
  late final dynamic phone;
  late final int osmId;
  late final String amenity;
  late final String cuisine;
  late final String smoking;
  late final String website;
  late final String building;
  late final String osmType;
  late final String addrcity;
  late final String addrstreet;
  late final int addrpostcode;
  late final String openingHours;
  late final String brandwikidata;
  late final String brandwikipedia;
  late final dynamic addrhousenumber;
  late final String airConditioning;

  Raw.fromJson(Map<String, dynamic> json) {
    bar = json['bar'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    osmId = json['osm_id'] ?? '';
    amenity = json['amenity'] ?? '';
    cuisine = json['cuisine'] ?? '';
    smoking = json['smoking'] ?? '';
    website = json['website'] ?? '';
    building = json['building'] ?? '';
    osmType = json['osm_type'] ?? '';
    addrcity = json['addr:city'] ?? '';
    addrstreet = json['addr:street'] ?? '';
    addrpostcode = json['addr:postcode'] ?? 0;
    openingHours = json['opening_hours'] ?? '';
    brandwikidata = json['brand:wikidata'] ?? '';
    brandwikipedia = json['brand:wikipedia'] ?? '';
    addrhousenumber = json['addr:housenumber'] ?? '';
    airConditioning = json['air_conditioning'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bar'] = bar;
    data['name'] = name;
    data['phone'] = phone;
    data['osm_id'] = osmId;
    data['amenity'] = amenity;
    data['cuisine'] = cuisine;
    data['smoking'] = smoking;
    data['website'] = website;
    data['building'] = building;
    data['osm_type'] = osmType;
    data['addr:city'] = addrcity;
    data['addr:street'] = addrstreet;
    data['addr:postcode'] = addrpostcode;
    data['opening_hours'] = openingHours;
    data['brand:wikidata'] = brandwikidata;
    data['brand:wikipedia'] = brandwikipedia;
    data['addr:housenumber'] = addrhousenumber;
    data['air_conditioning'] = airConditioning;
    return data;
  }
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });
  late final String type;
  late final List<double> coordinates;

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = List.castFrom<dynamic, double>(json['coordinates']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
