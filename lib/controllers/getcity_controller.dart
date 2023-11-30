import 'package:get/get.dart';
import 'package:guide/models/cities_model.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class GetCityController extends GetxController {
  RxList<dynamic> cityInfo = RxList<dynamic>();

  clearPlaces() {
    cityInfo.clear();
  }

  getCity(String cityid) async {
    cityInfo.clear();
    var response2 = await GetCity(cityid).getCityApi();
    if (response2 == "error") {
      cityInfo.add("error");
      // return logininfo;
    } else if (response2 == "notfound") {
      cityInfo.add("notfound");

      // return logininfo;
    } else {
      cityInfo.add(response2);
    }
  }
}

class GetCity {
  String? link;
  GetCity(String cityid) {
    link = '${serverUrl}/' /* private-content */;
  }
  late Uri url = Uri.parse(link!);

  Future getCityApi() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = getCityFromJson(response.body);

      return latescode;
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}
