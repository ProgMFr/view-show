import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:guide/models/search_model.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class MySearchController extends GetxController {
  RxList<dynamic> searchInfo = RxList<dynamic>();

  searchResult(
    String query,
  ) async {
    searchInfo.clear();
    String countryid = appdataprefs!.getString('countryid')!.toString();
    String cityid =
        appdataprefs?.getString('searchcitystring').toString() ?? "all";
    String placetype =
        appdataprefs?.getString('searchtypestring').toString() ?? "all";

    var response2 =
        await GetSearch(query, placetype, cityid, countryid).getSearch();
    if (response2 == "error") {
      searchInfo.add("error");
      return "error";
    } else if (response2 == "notfound") {
      searchInfo.add("notfound");
      return "error";
    } else {
      for (var item in response2) {
        searchInfo.add(item);
      }
    }
  }

  completeSearch(String query, int pagenum) async {
    String countryid = appdataprefs!.getString('countryid')!.toString();
    String cityid =
        appdataprefs?.getString('searchcitystring').toString() ?? "all";
    String placetype =
        appdataprefs?.getString('searchtypestring').toString() ?? "all";

    var response2 =
        await CompleteSearch(query, placetype, cityid, countryid, pagenum)
            .getSearch();
    if (response2 == "error") {
      return "error";
    } else if (response2 == "notfound") {
      return "error";
    } else {
      for (var item in response2) {
        searchInfo.add(item);
      }
    }
  }
}

class GetSearch {
  String? name;
  GetSearch(
    String quary,
    String placetype,
    String cityid,
    String countryid,
  ) {
    if (placetype == "all" && cityid == "all") {
      name =
          "${serverUrl}/"/* private-content */;
    } else if (placetype == "all" && cityid != "all") {
      name =
          "${serverUrl}/"/* private-content */;
    } else if (placetype != "all" && cityid == "all") {
      name =
          "${serverUrl}/"/* private-content */;
    } else if (placetype != "all" && cityid != "all") {
      name =
          "${serverUrl}/"/* private-content */;
    }
  }
  late Uri url = Uri.parse(name!);

  Future getSearch() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getSearchFromJson(response.body);
      return latescode.data;
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}

class CompleteSearch {
  String? name;
  CompleteSearch(String quary, String placetype, String cityid,
      String countryid, int pagenum) {
    if (placetype == "all" && cityid == "all") {
      name =
          "${serverUrl}/"/* private-content */;
    } else if (placetype == "all" && cityid != "all") {
      name =
         "${serverUrl}/"/* private-content */;
    } else if (placetype != "all" && cityid == "all") {
      name =
          "${serverUrl}/"/* private-content */;
    } else if (placetype != "all" && cityid != "all") {
      name =
          "${serverUrl}/"/* private-content */;
    }
  }
  late Uri url = Uri.parse(name!);

  Future getSearch() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getSearchFromJson(response.body);
      return latescode.data;
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}
