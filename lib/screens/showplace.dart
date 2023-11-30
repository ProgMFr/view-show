import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guide/controllers/nearest_place_controller.dart';
import 'package:guide/controllers/profile_controller.dart';
import 'package:guide/main.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:guide/views/colors.dart';
import 'package:guide/views/local_vars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:http/http.dart' as http;

class ShowPlace extends StatefulWidget {
  const ShowPlace({super.key});

  @override
  State<ShowPlace> createState() => _ShowPlaceState();
}

class _ShowPlaceState extends State<ShowPlace> {
  CarouselController carouselController = CarouselController();
  GetNearestPlaceController nearestPlaceController =
      Get.put(GetNearestPlaceController());
  late ProfileController profileController;
  final Completer<GoogleMapController> _controller = Completer();
  final name = Get.arguments[0];
  final data = Get.arguments[1];
  bool _showGoogleMaps = true;
  String nearestreuslt = "loading";
  bool fromprofile = Get.arguments[2] ?? false;

  late int picCount;
  late String save = appdataprefs!.getString("${data.id}") ?? "delete";
  int picIndex = 0;
  late String placeId;
  late Map socialMedia = {
    "facebook": data.socialMedia.facebook,
    "instagram": data.socialMedia.instagram,
    "telegram": data.socialMedia.telegram,
    "whatsapp": data.socialMedia.whatsapp,
  };
  Map<String, IconData> socialMediaIcon = {
    "facebook": FontAwesomeIcons.facebook,
    "instagram": FontAwesomeIcons.instagram,
    "telegram": FontAwesomeIcons.telegram,
    "whatsapp": FontAwesomeIcons.whatsapp,
  };
  Future savePlace(String placeId) async {
    Uri link = Uri.parse('${serverUrl}favorite_places/add?place_id=$placeId');
    Uri link2 =
        Uri.parse('${serverUrl}favorite_places/remove?place_id=$placeId');
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = save == "add"
        ? await http.delete(link2, headers: {"Authorization": header})
        : await http.post(link, headers: {"Authorization": header});
    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString());
      setState(() {
        appdataprefs!.setString("${data.id}", "add");
        save = "add";
      });
    } else if (response.statusCode == 202) {
      debugPrint(response.statusCode.toString());
      setState(() {
        appdataprefs!.setString("${data.id}", "delete");
        save = "delete";
      });
    } else {
      debugPrint(response.statusCode.toString());
      setState(() {
        appdataprefs!.setString("${data.id}", "add");
        save = "add";
      });
    }
  }

  @override
  void initState() {
    picCount = data.placeImages.length;
    placeId = data.id;
    nearestPlaceController.getPlaces(data.id);
    if (fromprofile) {
      profileController = Get.find();
    }
    super.initState();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _showGoogleMaps = false;
        });
        // await Future.delayed(const Duration(milliseconds: 200), () {
        //   Get.back();
        // });
        if (fromprofile) {
          profileController.getProfile();
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.w600,
              fontFamily: "redex",
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
        ),
        body: Obx(
          () => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //images container
                          Stack(
                            children: [
                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: CarouselSlider(
                                  items: [
                                    if (data.placeImages.length == 0) ...[
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color(0xfff5f6f9),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // margin: EdgeInsets.symmetric(horizontal: 1),
                                          child: Image.asset(
                                            "assest/images/arabiclogo.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ] else ...[
                                      for (int i = 0;
                                          i < data.placeImages.length;
                                          i++) ...[
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // margin: EdgeInsets.symmetric(horizontal: 1),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  data.placeImages[i].imageUrl,
                                              placeholder: (context, url) {
                                                return const BlurHash(
                                                  hash:
                                                      "L5H2EC=PM+yV0g-mq.wG9c010J}I",
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      ]
                                    ]
                                  ],
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    height: 300,
                                    aspectRatio: 16 / 9,
                                    viewportFraction:
                                        data.placeImages.length == 1
                                            ? 0.9
                                            : 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    enlargeCenterPage: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        picIndex = index;
                                      });
                                    },
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 8,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < picCount; i++) ...[
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Container(
                                              width: picIndex == i ? 12 : 8,
                                              height: picIndex == i ? 12 : 8,
                                              decoration: BoxDecoration(
                                                  color: picIndex == i
                                                      ? const Color(0xff0FD481)
                                                      : Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          0), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                            ),
                                          )
                                        ]
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    data.name,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (data.averageRating != 0) ...{
                                      const FaIcon(
                                        FontAwesomeIcons.solidStar,
                                        color: secondaryColor,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data.averageRating.toStringAsFixed(1),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    },
                                    GestureDetector(
                                      onTap: () {
                                        savePlace(placeId);
                                      },
                                      child: FaIcon(
                                        save == "add"
                                            ? FontAwesomeIcons.solidBookmark
                                            : FontAwesomeIcons.bookmark,
                                        color: secondaryColor,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // avilaible time container
                          if (data.type.toString().toLowerCase() ==
                              "stayplace") ...[
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple.withOpacity(0.1),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    child: const FaIcon(
                                      FontAwesomeIcons.solidClock,
                                      color: Colors.deepPurple,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      data.available.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: secondaryColor.withOpacity(0.1),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      data.price.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 15,
                                        fontFamily: "redex",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "دينار عراقي",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                          //location container
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blueGrey.withOpacity(0.1),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  child: const FaIcon(
                                    FontAwesomeIcons.locationDot,
                                    color: Colors.blueGrey,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    data.shortLocation,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // social media container
                          (data.socialMedia != null &&
                                      data.socialMedia != "null") &&
                                  data.type.toString().toLowerCase() !=
                                      "stayplace"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text("social".tr,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "redex",
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (var dataiem in data
                                                .socialMedia.isAvailable) ...[
                                              GestureDetector(
                                                onTap: () {
                                                  launchUrl(
                                                      Uri.parse(
                                                          socialMedia[dataiem]),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: FaIcon(
                                                    socialMediaIcon[dataiem],
                                                    color: dataiem ==
                                                            "instagram"
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
                                    ),
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          //description container
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "description".tr,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "redex",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SelectableText(
                                  data.description,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // map container
                          const SizedBox(height: 20),
                          _showGoogleMaps
                              ? mapContainer(
                                  data: data, controller: _controller)
                              : Container(),
                          const SizedBox(height: 20),
                          //nearest places container
                          nearestPlaceController.nearestInfo.isEmpty
                              ? Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                    color: const Color(0xff0FD481),
                                    size: 50,
                                  ),
                                )
                              : nearestPlaceController.nearestInfo[0] ==
                                          "notfound" ||
                                      nearestPlaceController.nearestInfo[0] ==
                                          "error"
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Text(
                                            "nearestplaces".tr,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "redex",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 110,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                for (var item
                                                    in nearestPlaceController
                                                        .nearestInfo) ...[
                                                  highestrateContainer(item),
                                                ]
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.grey.withOpacity(0.6),
                  child: Row(
                    mainAxisAlignment: data.phoneNumber == null ||
                            appdataprefs?.getString('country') != "IRAQ" &&
                                data.type.toString().toLowerCase() !=
                                    "stayplace"
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      data.phoneNumber == null ||
                              appdataprefs?.getString('country') != "IRAQ" &&
                                  data.type.toString().toLowerCase() !=
                                      "stayplace"
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                data.type.toString().toLowerCase() ==
                                        "stayplace"
                                    ? launchUrl(
                                        Uri.parse(
                                            "https://wa.me/$supportPhone"),
                                        mode: LaunchMode.externalApplication)
                                    : launchUrl(
                                        Uri.parse("tel:${data.phoneNumber}"),
                                        mode: LaunchMode.externalApplication);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                width:
                                    MediaQuery.of(context).size.width / 2 - 10,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      data.type.toString().toLowerCase() ==
                                              "stayplace"
                                          ? FontAwesomeIcons.whatsapp
                                          : FontAwesomeIcons.phoneFlip,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                        data.type.toString().toLowerCase() ==
                                                "stayplace"
                                            ? "support".tr
                                            : "callnow".tr,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/reviewscreen",
                              arguments: [placeId, "place"]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: data.phoneNumber == null ||
                                  appdataprefs?.getString('country') !=
                                          "IRAQ" &&
                                      data.type.toString().toLowerCase() !=
                                          "stayplace"
                              ? 250
                              : 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.white,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text("review".tr,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class mapContainer extends StatelessWidget {
  const mapContainer({
    super.key,
    required this.data,
    required Completer<GoogleMapController> controller,
  }) : _controller = controller;

  final data;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "location".tr,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: "redex",
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(data.latitude, data.longitude),
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  // zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  liteModeEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId("1"),
                      position: LatLng(data.latitude, data.longitude),
                    )
                  },
                ),
              ),
            ),
            Positioned.fill(child: GestureDetector(
              onTap: () async {
                // try {
                //   String googleUrl =
                //       'https://www.google.com/maps/search/?api=1&query=${data.latitude},${data.longitude}';
                //   if (await canLaunch(googleUrl)) {
                //     await launch(googleUrl);
                //   } else {
                //     throw 'Could not open the map.';
                //   }
                // } catch (e) {
                //   print(e);
                // }

                MapsLauncher.launchCoordinates(
                    data.latitude, data.longitude, data.name);
              },
            ))
          ],
        )
      ],
    );
  }
}

GestureDetector highestrateContainer(item) {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/showplace",
          arguments: [item.name, item, false], preventDuplicates: false);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          item.placeImages.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        Image.asset("assest/icon/icon.png", fit: BoxFit.cover),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(5),
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
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            child: Text(item.name,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        Image.asset(
                          images[item.type.toString().toLowerCase()]!,
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(item.type.toString().toLowerCase().tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),
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
                      if (item.price != null &&
                          item.type.toString().toLowerCase() ==
                              "stayplace") ...{
                        Row(
                          children: [
                            Text(
                              "${item.price}",
                              style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const FaIcon(
                              FontAwesomeIcons.dollarSign,
                              size: 10,
                              color: secondaryColor,
                            ),
                          ],
                        ),
                      },
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
