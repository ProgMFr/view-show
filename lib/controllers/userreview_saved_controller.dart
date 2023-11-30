import 'dart:convert';
import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:guide/models/classes/place_class.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class UserReviewController extends GetxController {
  RxList<dynamic> userReviewInfo = RxList<dynamic>();

  clearReview() {
    userReviewInfo.clear();
  }

  List<Place> userReviewFromJson(String str) =>
      List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));

  String userReviewToJson(List<Place> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Uri link = Uri.parse('${serverUrl}/' /* private-content */);
  Future getReviews() async {
    userReviewInfo.clear();
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.get(link, headers: {"Authorization": header});
    if (response.statusCode == 200) {
      var jsonresponse = userReviewFromJson(response.body);
      for (var item in jsonresponse) {
        userReviewInfo.add(item);
      }
    } else if (response.statusCode == 404) {
      userReviewInfo.add("notfound");
    } else {
      userReviewInfo.add("error");
    }
  }
}

class UserBookmarkController extends GetxController {
  RxList<dynamic> userBookmarkInfo = RxList<dynamic>();

  clearReview() {
    userBookmarkInfo.clear();
  }

  Uri link = Uri.parse('${serverUrl}/' /* private-content */);
  Future getBookmarks() async {
    userBookmarkInfo.clear();
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.get(link, headers: {"Authorization": header});
    if (response.statusCode == 200) {
      var jsonresponse = userReview2FromJson(response.body);
      for (var item in jsonresponse) {
        userBookmarkInfo.add(item.place);
      }
    } else if (response.statusCode == 404) {
      userBookmarkInfo.add("notfound");
    } else {
      userBookmarkInfo.add("error");
    }
  }
}

List<GetBookmarks> userReview2FromJson(String str) => List<GetBookmarks>.from(
    json.decode(str).map((x) => GetBookmarks.fromJson(x)));

String userReview2ToJson(List<GetBookmarks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBookmarks {
  String? id;
  Place? place;

  GetBookmarks({
    this.id,
    this.place,
  });

  factory GetBookmarks.fromJson(Map<String, dynamic> json) => GetBookmarks(
        id: json["id"],
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place": place?.toJson(),
      };
}
