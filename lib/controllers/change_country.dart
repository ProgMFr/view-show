import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:guide/models/country_model.dart';
import 'package:guide/views/colors.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../views/local_vars.dart';

class CountryController extends GetxController {
  RxList<dynamic> countriesInfo = RxList<dynamic>();

  checkCountries() async {
    countriesInfo.clear();
    String country = appdataprefs!.getString('country')!.toString();
    var response2 = await GetCountry(country).getContry();
    if (response2 == "error") {
      countriesInfo.add("error");
      return "error";
    } else if (response2 == "notfound") {
      countriesInfo.add("notfound");

      return "notfound";
    } else {
      if (response2.appVersion != currentVersion) {
        Get.dialog(
          barrierDismissible: false,
          WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assest/images/arabiclogo.png",
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "update".tr,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "updatecontent".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        launchUrl(Uri.parse(response2.androidUrl!),
                            mode: LaunchMode.externalApplication);
                      } else {
                        launchUrl(Uri.parse(response2.iosUrl!),
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "updatebutton".tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        );
      }
      countriesInfo.add(response2);
      appdataprefs!.setString("countryid", response2.countryId);
      appdataprefs!.setInt("searchcity", 300);
      appdataprefs!.setString("searchcitystring", '');
    }
  }
}

class GetCountry {
  String? name;
  GetCountry(String cname) {
    name = '${serverUrl}/' /* private-content */;
  }
  late Uri url = Uri.parse(name!);

  Future getContry() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var latescode = countryHomeFromJson(response.body);
      return latescode;
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}
