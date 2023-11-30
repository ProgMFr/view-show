import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:guide/models/review_model.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class GetReviewsController extends GetxController {
  RxList<dynamic> reviewsInfo = RxList<dynamic>();

  clearReview() {
    reviewsInfo.clear();
  }

  getReview(String placeId, String type) async {
    reviewsInfo.clear();
    var response2 = await GetReviews(placeId, type).getReviews();

    if (response2 == "error") {
      reviewsInfo.add("error");
      // return logininfo;
    } else if (response2 == "notfound") {
      reviewsInfo.add("notfound");

      // return logininfo;
    } else {
      reviewsInfo.add(response2);
    }
  }

  Future createReview(
      String placeid, String comment, int rate, String type) async {
    var jsonComment = comment.replaceAll("\n", " ");
    String link;
    type == "place"
        ? link = '${serverUrl}'/* private-content */
        : link =
            '${serverUrl}'/* private-content */;
    late Uri url = Uri.parse(link);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var body = '{"comment": "${jsonComment.toString()}","rating": $rate}';
    var response =
        await http.post(url, body: body, headers: {"Authorization": header});
    if (response.statusCode == 200) {
      return "done";
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }

  Future removeReview(String reviewId, String placeid) async {
    String link = '${serverUrl}'/* private-content */;
    late Uri url = Uri.parse(link);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.delete(url, headers: {"Authorization": header});
    if (response.statusCode == 200) {
      return "done";
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }

  Future reportReview(String reviewId) async {
    String link = '${serverUrl}'/* private-content */;
    late Uri url = Uri.parse(link);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.post(
      url,
      headers: {"Authorization": header},
    );
    if (response.statusCode == 200) {
      return "done";
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}

class GetReviews {
  String? link;
  String userId = appdataprefs!.getString("userid").toString();
  GetReviews(String placeId, String type) {
    type == "place"
        ? link =
            '${serverUrl}'/* private-content */
        : link =
            '${serverUrl}'/* private-content */;
  }
  late Uri url = Uri.parse(link!);

  Future getReviews() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getReviewsFromJson(response.body);
      // print(latescode[0].id);
      return latescode;
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}
