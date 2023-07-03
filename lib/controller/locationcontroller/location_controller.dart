import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class LocationController extends ChangeNotifier {
  final String googleMapsAPI = 'https://maps.googleapis.com/maps/api/geocode/json?';
  final apiKey = '';

  Future<LocationPermission> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    return permission;
  }

  Future<void> determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    while (true){
      if (permission==LocationPermission.whileInUse || permission==LocationPermission.always){
        break;
      }
      permission = await _requestLocationPermission();
    }
    Position position= await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true
    );
    getLocation('${position.latitude.toString()},${position.longitude.toString()}');
  }

  String address = '';
  String area = '';
  String district = '';
  String state = '';
  String country = '';

  Future<void> getLocation(String latlang) async {
    String gmapsApiUri =
        '${googleMapsAPI}latlng=$latlang&location_type=APPROXIMATE&key=$apiKey';
    var response = await http.get(Uri.parse(gmapsApiUri));
    if (response.statusCode == 200){
      var json = jsonDecode(response.body);
      address = json['plus_code']['compound_code'];
      area = json['plus_code']['compound_code'].toString().split(' ')[1].replaceAll(',', '');
      district = json['results'][2]['address_components'][1]['long_name'];
      state = json['results'][2]['address_components'][2]['long_name'];
      country = json['results'][2]['address_components'][3]['long_name'];
    }
  }

}
