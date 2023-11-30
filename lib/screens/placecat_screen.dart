import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guide/controllers/getcity_controller.dart';
import 'package:guide/screens/widgets/homescreen/adsbanner.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:guide/views/local_vars.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../views/colors.dart';

class PlaceCatePage extends StatefulWidget {
  const PlaceCatePage({super.key});

  @override
  State<PlaceCatePage> createState() => _PlaceCatePageState();
}

class _PlaceCatePageState extends State<PlaceCatePage> {
  late GetCityController getCityController;
  var ags = Get.arguments[0];
  var cityid = Get.arguments[1];
  List<String> images = [
    "assest/images/placecate/holyplace.png",
    "assest/images/placecate/tourist.png",
    "assest/images/placecate/stay.png",
    "assest/images/placecate/mall.png",
    "assest/images/placecate/sport.png",
    "assest/images/placecate/salon.png",
    "assest/images/placecate/restaurant.png",
    "assest/images/placecate/host.png",
    "assest/images/placecate/cafe.png",
    "assest/images/placecate/park.png",
    "assest/images/placecate/gas.png",
    "assest/images/placecate/finan.png",
  ];
  @override
  void initState() {
    getCityController = Get.put(GetCityController());
    getCityController.getCity(cityid);
    //
    // print(getCityController.cityInfo[0].latestPlaces);
    super.initState();
  }

  @override
  void dispose() {
    getCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(ags,
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
          () => getCityController.cityInfo.isEmpty
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xff0FD481),
                    size: 50,
                  ),
                )
              : getCityController.cityInfo[0] == "notfound" ||
                      getCityController.cityInfo[0] == "error"
                  ? notAvilable("notavilable", 250)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          adsBanner(
                              context,
                              getCityController.cityInfo[0].advertisements,
                              supportPhone),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ResponsiveGridRow(
                              children: [
                                // ResponsiveGridCol(
                                //   xs: 12,
                                //   child: Container(
                                //     padding: EdgeInsets.symmetric(vertical: 10),
                                //     child: adsBanner(context,),
                                //   ),
                                // ),

                                cateItem(
                                    images[1], 'touristplace', cityid, null),
                                cateItem(images[0], 'holyplace', cityid,
                                    listSubTypes["holyplace"]),
                                cateItem(
                                    images[2],
                                    "stayplace",
                                    cityid,
                                    [
                                      listSubTypes["stayplace"],
                                      ["low", "high"]
                                    ].expand((x) => x).toList()),
                                cateItem(images[6], 'restaurant', cityid,
                                    listSubTypes["restaurant"]),
                                cateItem(images[8], 'cafe', cityid, null),
                                cateItem(images[9], 'entertainment', cityid,
                                    listSubTypes["entertainment"]),
                                cateItem(images[3], 'mall', cityid,
                                    listSubTypes["mall"]),
                                cateItem(
                                    images[10], 'gasstation', cityid, null),

                                cateItem(images[7], 'healthcenter', cityid,
                                    listSubTypes["healthcenter"]),

                                cateItem(images[4], 'sport', cityid,
                                    listSubTypes["sport"]),
                                cateItem(images[5], 'salons', cityid,
                                    listSubTypes["salons"]),

                                cateItem(images[11], 'financial', cityid,
                                    listSubTypes["financial"]),
                              ],
                            ),
                          ),
                          getCityController
                                  .cityInfo[0].highestRatedPlaces.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "highrate".tr,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          for (var item in getCityController
                                              .cityInfo[0]
                                              .highestRatedPlaces) ...[
                                            highestrateContainer(item),
                                          ]
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 14,
                          ),
                          getCityController.cityInfo[0].latestPlaces.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "latest".tr,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      for (var item in getCityController
                                          .cityInfo[0].latestPlaces) ...[
                                        placeContainer(item.place, true),
                                      ],
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
        ));
  }

  GestureDetector highestrateContainer(item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/showplace", arguments: [item.name, item, false]);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 100,
        width: 320,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            item.placeImages.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assest/icon/icon.png"),
                        fit: BoxFit.contain,
                        opacity: 0.5,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl: item.placeImages[0].imageUrl,
                          placeholder: (context, url) {
                            return const BlurHash(
                                hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
                          },
                          fit: BoxFit.cover),
                    ),
                  ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(item.name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              )),
                          const Spacer(),
                          Row(
                            children: [
                              Text(item.averageRating.toStringAsFixed(1),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: secondaryColor,
                                    fontSize: 13,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(width: 2),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: FaIcon(
                                  FontAwesomeIcons.solidStar,
                                  size: 12,
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        // color: Colors.red,
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(item.description,
                            maxLines: 3,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              height: 1.2,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 12,
                          color: Colors.indigo,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(item.shortLocation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ResponsiveGridCol cateItem(
      String image, String type, String cityid, var subTypes) {
    return ResponsiveGridCol(
      xs: 3,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/places', arguments: [cityid, type, subTypes]);
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 100,
          child: Stack(
            children: [
              Container(
                // alignment: Alignment.center,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: 13),
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10.0,
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ]),
                            child: Image.asset(
                              image,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              type.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                height: 1,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
