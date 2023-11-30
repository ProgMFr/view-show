import 'dart:convert';

import 'package:get/get.dart';
import 'package:guide/models/classes/place_class.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class GetNearestPlaceController extends GetxController {
  List<Place> getPlaces2FromJson(String str) =>
      List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));

  String getPlaces2FToJson(List<Place> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  RxList<dynamic> nearestInfo = RxList<dynamic>();

  getPlaces(String placeId) async {
    nearestInfo.clear();
    var url = Uri.parse('${serverUrl}/' /* private-content */);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getPlaces2FromJson(response.body);
      for (var item in latescode) {
        nearestInfo.add(item);
      }
    } else if (response.statusCode == 404) {
      nearestInfo.add("notfound");
    } else {
      nearestInfo.add("error");
    }
  }
}
