import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/models/get_places_model.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class GetPlacesController extends GetxController {
  RxList<dynamic> placesInfo = RxList<dynamic>();

  clearPlaces() {
    placesInfo.clear();
  }

  getPlaces(String cityid, String placetype, int pagenum) async {
    Uri url = Uri.parse('${serverUrl}/' /* private-content */);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getPlacesFromJson(response.body);
      debugPrint(response.statusCode.toString());
      for (var item in latescode.data!) {
        placesInfo.add(item);
      }
    } else if (response.statusCode == 404) {
      debugPrint(response.statusCode.toString());

      clearPlaces();
      placesInfo.add("notfound");
    } else {
      debugPrint(response.statusCode.toString());

      clearPlaces();
      placesInfo.add("notfound");
    }
  }

  getPlacesWithType(
      String cityid, String placetype, int pagenum, String subtype) async {
    Uri url = Uri.parse('${serverUrl}/' /* private-content */);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getPlacesFromJson(response.body);
      debugPrint(response.statusCode.toString());
      for (var item in latescode.data!) {
        placesInfo.add(item);
      }
    } else if (response.statusCode == 404) {
      clearPlaces();
      placesInfo.add("notfound");
    } else {
      clearPlaces();
      placesInfo.add("notfound");
    }
  }

  getPlacesWithprice(String cityid, int pagenum, String price) async {
    Uri url = Uri.parse('${serverUrl}/' /* private-content */);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getPlacesFromJson(response.body);
      debugPrint(response.statusCode.toString());
      for (var item in latescode.data!) {
        placesInfo.add(item);
      }
    } else if (response.statusCode == 404) {
      clearPlaces();
      placesInfo.add("notfound");
    } else {
      clearPlaces();
      placesInfo.add("notfound");
    }
  }
}
