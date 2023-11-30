import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/change_country.dart';
import 'package:guide/main.dart';
import 'package:guide/screens/widgets/homescreen/adsbanner.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/views/local_vars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../screens/widgets/homescreen/country_button.dart';
import '../screens/widgets/homescreen/offerbanner.dart';
import '../screens/widgets/homescreen/advicebutton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    appdataprefs!.setInt("searchtype", 0);
    appdataprefs!.setString("searchtypestring", "all");
    appdataprefs!.setInt("searchcity", 300);
    appdataprefs!.setString("searchcitystring", "all");
    appdataprefs!.setBool("filtered", false);
    super.initState();
  }

  CountryController countryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => countryController.countriesInfo.isNotEmpty
          ? countryController.countriesInfo[0] == "notfound" ||
                  countryController.countriesInfo[0] == "error"
              ? Center(child: notAvilable("notavilable", 250))
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          adsBanner(
                              context,
                              countryController.countriesInfo[0].advertisements,
                              supportPhone),
                          countryContainer(
                              countryController.countriesInfo[0].cities),
                          adviceBanner(countryController
                              .countriesInfo[0].recommendedPlaces),
                          offerBanner(
                              countryController.countriesInfo[0].offers),
                          // adviceBanner(),
                          // create fake items
                        ],
                      )),
                )
          : Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xff0FD481),
                size: 50,
              ),
            ),
    );
  }
}
