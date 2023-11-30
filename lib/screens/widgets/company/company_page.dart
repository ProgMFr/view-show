// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guide/controllers/booking_controller.dart';

import 'package:get/get.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:guide/views/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notavilable.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  late GetCompanyController getCompanyController;
  var comapny = Get.arguments[0];
  var companyId = Get.arguments[1];
  late Map socialMedia = {
    "facebook": comapny.socialMedia.facebook,
    "instagram": comapny.socialMedia.instagram,
    "telegram": comapny.socialMedia.telegram,
    "whatsapp": comapny.socialMedia.whatsapp,
  };
  Map<String, IconData> socialMediaIcon = {
    "facebook": FontAwesomeIcons.facebook,
    "instagram": FontAwesomeIcons.instagram,
    "telegram": FontAwesomeIcons.telegram,
    "whatsapp": FontAwesomeIcons.whatsapp,
  };
  @override
  void initState() {
    getCompanyController = Get.put(GetCompanyController());
    getCompanyController.getCompany(companyId);
    super.initState();
  }

  @override
  void dispose() {
    getCompanyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(comapny.companyName,
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
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  if (comapny.image != null)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(comapny.image),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          comapny.image == null
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 140,
                                  height: 140,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "assest/icon/icon.png",
                                        fit: BoxFit.cover,
                                      )),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 140,
                                  height: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                        imageUrl: comapny.image,
                                        placeholder: (context, url) {
                                          return const BlurHash(
                                              hash:
                                                  "L5H2EC=PM+yV0g-mq.wG9c010J}I");
                                        },
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text("companyinfo".tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      height: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 5),
                                Text(comapny.companyDescription,
                                    maxLines: 6,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      height: 1.2,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    comapny.socialMedia != null && comapny.socialMedia != "null"
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              children: [
                                Text("companysocialmedia".tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var dataiem in comapny
                                          .socialMedia.isAvailable) ...[
                                        GestureDetector(
                                          onTap: () {
                                            launchUrl(
                                                Uri.parse(socialMedia[dataiem]),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: FaIcon(
                                              socialMediaIcon[dataiem],
                                              color: dataiem == "instagram"
                                                  ? Colors.red
                                                  : dataiem == "whatsapp"
                                                      ? Colors.green
                                                      : Colors.blue,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(
                            height: 15,
                          ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                MapsLauncher.launchCoordinates(comapny.latitude,
                                    comapny.longitude, comapny.companyName);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.locationDot,
                                        color: Colors.deepOrange, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      "plocation".tr,
                                      style: const TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/reviewscreen",
                                  arguments: [companyId, "company"]);
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FaIcon(FontAwesomeIcons.solidStar,
                                      color: secondaryColor, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    "review".tr,
                                    style: const TextStyle(
                                      color: secondaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text("tripsavilable".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              getCompanyController.tripsList.isEmpty
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: const Color(0xff0FD481),
                        size: 50,
                      ),
                    )
                  : getCompanyController.tripsList[0] == "notfound" ||
                          getCompanyController.tripsList[0] == "error"
                      ? Center(child: notAvilable("notavilable", 250))
                      : Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListView.builder(
                              itemCount: getCompanyController
                                  .tripsList[0].tripDetails.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: tripContainer(getCompanyController
                                      .tripsList[0].tripDetails[i]),
                                );
                              },
                            ),
                          ),
                        ),
            ],
          ),
        ));
  }
}
