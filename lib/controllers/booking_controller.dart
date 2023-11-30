import 'package:get/get.dart';
import 'package:guide/models/companies_model.dart';
import 'package:http/http.dart' as http;
import '../views/local_vars.dart';

class GetCompaniesController extends GetxController {
  RxList<dynamic> companiesLists = RxList<dynamic>();

  clearPlaces() {
    companiesLists.clear();
  }

  getCompanies(String cityName) async {
    companiesLists.clear();
    var response2 = await getCompaniesApi(cityName);
    if (response2 == "error") {
      companiesLists.add("error");
    } else if (response2 == "notfound") {
      companiesLists.add("notfound");
    } else {
      for (var item in response2) {
        companiesLists.add(item);
      }
    }
  }
}

Future getCompaniesApi(String cityName) async {
  Uri link = Uri.parse('${serverUrl}/' /* private-content */);
  var response = await http.get(link);
  if (response.statusCode == 200) {
    var latescode = getCompaniesFromJson(response.body);
    return latescode;
  } else if (response.statusCode == 404) {
    return "notfound";
  } else {
    return "error";
  }
}

class GetCompanyController extends GetxController {
  RxList<dynamic> tripsList = RxList<dynamic>();

  clearPlaces() {
    tripsList.clear();
  }

  getCompany(String companyId) async {
    tripsList.clear();
    var response2 = await getCompanyApi(companyId);
    if (response2 == "error") {
      tripsList.add("error");
    } else if (response2 == "notfound") {
      tripsList.add("notfound");
    } else {
      tripsList.add(response2);
    }
  }
}

Future getCompanyApi(String companyId) async {
  Uri link = Uri.parse('${serverUrl}/' /* private-content */);
  var response = await http.get(link);
  if (response.statusCode == 200) {
    var latescode = getCompanyFromJson(response.body);
    return latescode;
  } else if (response.statusCode == 404) {
    return "notfound";
  } else {
    return "error";
  }
}
