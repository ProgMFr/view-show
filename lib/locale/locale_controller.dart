import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/main.dart';

class LocaleController extends GetxController {
  @override
  void onInit() {
    if (appdataprefs!.getString("language") == null) {
      appdataprefs!.setString("language", Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }

  Locale language = appdataprefs!.getString("language") == "ar"
      ? const Locale('ar')
      : (appdataprefs!.getString("language") == "en"
          ? const Locale('en')
          : Get.deviceLocale!);

  void changeLocale(Locale l, String langname) {
    appdataprefs!.setString('language', langname);
    Get.updateLocale(l);
    // update();
  }
}
