import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Spot {
  static String baseUrl = "5ddbb358041ac10014de140b.mockapi.io";
  static int uniqueId = 200;
  String id;
  String createdAt;
  String cityName;
  String country;
  String latitude;
  String longitude;
  String whenToGo;
  int windProbability;

  Spot(String id, String createdAt, String cityName, String country,
      String latitude, String longitude, int windProbability, String whenToGo) {
    this.id = id;
    this.createdAt = createdAt;
    this.cityName = cityName;
    this.country = country;
    this.latitude = latitude;
    this.longitude = longitude;
    this.whenToGo = whenToGo;
    this.windProbability = windProbability;
  }

  Spot.post(String cityName, String country, String latitude, String longitude,
      int windProbability, String whenToGo) {
    this.id = uniqueId.toString();
    uniqueId += 1;
    this.createdAt = DateTime.now().toString();
    this.cityName = cityName;
    this.country = country;
    this.latitude = latitude;
    this.longitude = longitude;
    this.whenToGo = whenToGo;
    this.windProbability = windProbability;
  }

  Map<String, dynamic> toData() {
    return {
      'name': cityName,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'month': whenToGo,
      'wind_prob': windProbability
    };
  }

  static void printSpot(Spot s) {
    print("id: " +
        s.id +
        "\ncreatedAt: " +
        s.createdAt +
        "\ncityName: " +
        s.cityName +
        "\ncountry: " +
        s.country +
        "\nlatitude: " +
        s.latitude +
        "\nlongitude: " +
        s.longitude +
        "\nprobability: " +
        s.windProbability.toString() +
        "\nmonth: " +
        s.whenToGo);
  }

  static bool isLatAndLongDouble(var lat, var long) {
    if(lat == null || long == null) {
      return false;
    }
    return lat is double && long is double;
  }

  static bool isProbabilityNumeric(var s) {
    if(s == null) {
      return false;
    }
    return s is int;
  }

  factory Spot.fromJson(Map<String, dynamic> json) {
    if (isProbabilityNumeric(json['probability']) == false)
      return Spot(
        json['id'],
        json['createdAt'],
        json['name'],
        json['country'],
        json['lat'].toString(),
        json['long'].toString(),
        int.parse(json['probability']),
        json['month'],
      );
    return Spot(
      json['id'],
      json['createdAt'],
      json['name'],
      json['country'],
      json['lat'].toString(),
      json['long'].toString(),
      json['probability'],
      json['month'],
    );
  }

  static Future<List<Spot>> getSpots() async {
    final response = await http.get(Uri.https(baseUrl, 'spot'));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      List jsonArrayOfSpots = [];
      jsonArrayOfSpots = jsonDecode(response.body);
      List<Spot> listOfSpots = [];
      listOfSpots =
          jsonArrayOfSpots.map((item) => Spot.fromJson(item)).toList();
      return listOfSpots;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load spots' +
          ' status code: ' +
          response.statusCode.toString());
    }
  }
}
