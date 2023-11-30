import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (appdataprefs!.getBool('islogin') == true) {
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}
