// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guide/controllers/booking_controller.dart';

import 'package:get/get.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../placecard.dart';

class CityCompanyPage extends StatefulWidget {
  const CityCompanyPage({super.key});

  @override
  State<CityCompanyPage> createState() => _CityCompanyPageState();
}

class _CityCompanyPageState extends State<CityCompanyPage> {
  late GetCompaniesController getCompaniesController;
  var cityName = Get.arguments;
  @override
  void initState() {
    getCompaniesController = Get.put(GetCompaniesController());
    getCompaniesController.getCompanies(cityName);
    super.initState();
  }

  @override
  void dispose() {
    getCompaniesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(cityName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'redex')),
          backgroundColor: Colors.white,
          elevation: 0,
          // toolbarHeight: 60,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
        ),
        body: Obx(
          () => getCompaniesController.companiesLists.isEmpty
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xff0FD481),
                    size: 50,
                  ),
                )
              : getCompaniesController.companiesLists[0] == "notfound" ||
                      getCompaniesController.companiesLists[0] == "error"
                  ? Center(child: notAvilable("notavilable", 250))
                  : ListView.builder(
                      itemCount: getCompaniesController.companiesLists.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: companyContainer(
                              getCompaniesController.companiesLists[i]),
                        );
                      },
                    ),
        ));
  }
}
