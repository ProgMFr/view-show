import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guide/controllers/profile_controller.dart';
import 'package:guide/views/colors.dart';
import 'package:guide/views/local_vars.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class MerchantAddPlace extends StatefulWidget {
  const MerchantAddPlace({super.key});

  @override
  State<MerchantAddPlace> createState() => _MerchantAddPlaceState();
}

class _MerchantAddPlaceState extends State<MerchantAddPlace> {
  ProfileController profileController = Get.find();
  MerchantController merchantController = Get.find();
  final RegExp allowedPattern = RegExp(r'^[a-zA-Z0-9._]+$');
  final RegExp telegramUrlPattern = RegExp(
    r'^https?:\/\/(t(?:elegram)?\.me|telegram\.org)\/[a-zA-Z0-9_]{5,}$',
  );
  final RegExp facebookUrlPattern = RegExp(
    r'^https?:\/\/(www\.)?facebook\.com\/[a-zA-Z0-9.-]+\/?$',
  );
  final RegExp instagramUrlPattern = RegExp(
    r'^https?:\/\/(www\.)?instagram\.com\/[a-zA-Z0-9_.]+\/?$',
  );
  int phonenumber = 0;
  bool namevalid = false;
  bool pricevaild = false;
  bool priceenable = false;
  bool avilablevalid = false;
  bool descriptionvalid = false;
  bool shortlocationvalid = false;
  bool phonevalid = false;
  bool whatsappvalid = false;
  bool telegramavalid = false;
  bool facebookvalid = false;
  bool instagramvalid = false;
  bool whatsappcheck = false;
  bool telegramcheck = false;
  bool facebookcheck = false;
  bool instagramcheck = false;
  bool termscheck = false;
  bool loading = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController avilablecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController telegramcontroller = TextEditingController();
  TextEditingController whatsappcontroller = TextEditingController();
  TextEditingController facebookcontroller = TextEditingController();
  TextEditingController instagramcontroller = TextEditingController();
  TextEditingController shortlocationcontroller = TextEditingController();
  double logitude = 44.3661;
  double latitude = 33.3152;
  List<String> cities = ["loading"];
  List citiesId = [];
  String selectedcity = 'loading';
  String selectedcityId = "";
  int cityindex = 0;
  final Completer<GoogleMapController> _controller = Completer();

  String selectedtype = 'stayplace'; // Initial value for the first dropdown
  String selectedSubtype = 'hotel'; // Initial value for the second dropdown

  // Define the items for both dropdowns
  final List<String> mainTypes = [
    "stayplace",
    "mall",
    "healthcenter",
    "restaurant",
    "entertainment",
    "gasstation",
    "cafe",
    "sport",
    "salons",
    "financial",
  ];
  Map<String, String> images = {
    "stayplace": "assest/images/placecate/stay.png",
    "mall": "assest/images/placecate/mall.png",
    "sport": "assest/images/placecate/sport.png",
    "salons": "assest/images/placecate/salon.png",
    "restaurant": "assest/images/placecate/restaurant.png",
    "healthcenter": "assest/images/placecate/host.png",
    "cafe": "assest/images/placecate/cafe.png",
    "entertainment": "assest/images/placecate/park.png",
    "gasstation": "assest/images/placecate/gas.png",
    "financial": "assest/images/placecate/finan.png",
  };
  final Map<String, List<String>> subTypes = {
    "stayplace": listSubTypes["stayplace"]!,
    "mall": listSubTypes["mall"]!,
    "healthcenter": listSubTypes["healthcenter"]!,
    "restaurant": listSubTypes["restaurant"]!,
    "entertainment": listSubTypes["entertainment"]!,
    "gasstation": ['notfounds'],
    "cafe": ['notfounds'],
    "sport": listSubTypes["sport"]!,
    "salons": listSubTypes["salons"]!,
    "financial": listSubTypes["financial"]!,
  };
  @override
  void initState() {
    fetchCities();
    super.initState();
  }

  fetchCities() async {
    var result = await http
        .get(Uri.parse("https://view.viewiraq.de/api/countries/cites/Iraq"));
    if (result.statusCode == 200) {
      var decodedResult = jsonDecode(result.body);
      setState(() {
        for (var item in decodedResult) {
          cities.add(item["city_name"]);
          citiesId.add(item["id"]);
        }
        selectedcityId = decodedResult[0]["id"];
        selectedcity = decodedResult[0]["city_name"];
        // print(selectedcityId);
        cities.remove(cities.first);
      });
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  setMap(var value) async {
    setState(() {
      logitude = value[0];
      latitude = value[1];
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(value[1], value[0]), zoom: 14.4746)));
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        profileController.getProfile();
        merchantController.getPlace();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("paddnew".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'redex')),
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0,
          // toolbarHeight: 60,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //! change city
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "requiredfiled".tr,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dubai'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "pcity".tr,
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'redex'),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 180,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          child: DropdownButton<String>(
                            value: selectedcity,
                            onChanged: (value) {
                              setState(() {
                                selectedcity = value!;
                                cityindex = cities.indexOf(value);
                                selectedcityId = citiesId[cityindex];
                              });
                            },
                            borderRadius: BorderRadius.circular(10.0),
                            isExpanded: true,
                            menuMaxHeight: 250,
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'dubai',
                                height: 1),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            items: cities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      value.tr,
                                      style: const TextStyle(height: 2),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //! change type
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "requiredfiled".tr,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dubai'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "ptype".tr,
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'redex'),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 180,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          child: DropdownButton<String>(
                            value: selectedtype,
                            onChanged: profileController.profileInfo[0].isfree
                                ? null
                                : (value) {
                                    setState(() {
                                      selectedtype = value!;
                                      selectedSubtype =
                                          subTypes[selectedtype]!.first;
                                    });
                                  },
                            borderRadius: BorderRadius.circular(10.0),
                            isExpanded: true,
                            menuMaxHeight: 250,
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'dubai',
                                height: 1),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            items: mainTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      images[value]!,
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      value.tr,
                                      style: const TextStyle(height: 2),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //! change subtype
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "requiredfiled".tr,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dubai'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "psubtype".tr,
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'redex'),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 180,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          child: DropdownButton<String>(
                            value: selectedSubtype,
                            onChanged: (value) {
                              setState(() {
                                selectedSubtype = value!;
                              });
                            },
                            isExpanded: true,
                            menuMaxHeight: 250,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'dubai',
                                height: 1),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            items: subTypes[selectedtype]!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value.tr,
                                  style: const TextStyle(height: 2),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //! place name
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "pname".tr,
                      style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'redex'),
                    ),
                  ),
                  cTextFiled(TextInputType.text, Iconsax.subtitle,
                      namecontroller, namevalid, "placenamevalidation".tr),
                  //! description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "pdescription".tr,
                      style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'redex'),
                    ),
                  ),
                  cTextFiled(
                      TextInputType.multiline,
                      Iconsax.document_text,
                      descriptioncontroller,
                      descriptionvalid,
                      "descriptionvalidation".tr),
                  //! short location
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "pshortlocation".tr,
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'redex'),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "requiredfiled".tr,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'dubai'),
                          ),
                        ),
                        Text(
                          "pshortlocationex".tr,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'dubai'),
                        ),
                      ],
                    ),
                  ),
                  cTextFiled(
                      TextInputType.text,
                      Iconsax.location,
                      shortlocationcontroller,
                      shortlocationvalid,
                      "emptyfield".tr),
                  //! location on map
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "plocation".tr,
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'redex'),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "requiredfiled".tr,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'dubai'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //map container
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, logitude),
                          zoom: 14.4746,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        // // zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId('1'),
                            position: LatLng(latitude, logitude),
                          )
                        },
                        zoomControlsEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        liteModeEnabled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Get.toNamed("/mappicker")?.then((value) => setState(() {
                              if (value != null) {
                                setMap(value);
                              }
                            }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.map,
                            color: Colors.white,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("setlocationonmap".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "redex",
                              )),
                        ],
                      ),
                    ),
                  ),

                  //! phone number
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "pcontact".tr,
                      style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'redex'),
                    ),
                  ),
                  cTextFiled(TextInputType.number, Iconsax.call,
                      phonecontroller, phonevalid, "phonevalidation".tr),

                  //! if free account
                  if (profileController.profileInfo[0].isfree ||
                      selectedtype == "stayplace") ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        "pprice".tr,
                        style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'redex'),
                      ),
                    ),
                    cTextFiled(TextInputType.number, Iconsax.dollar_circle,
                        pricecontroller, pricevaild, "emptyfield".tr),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "pavilable".tr,
                            style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'redex'),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "pavilableex".tr,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'dubai'),
                          ),
                        ],
                      ),
                    ),
                    cTextFiled(TextInputType.text, Iconsax.calendar_tick,
                        avilablecontroller, avilablevalid, "emptyfield".tr)
                  ] else ...[
                    //! socialmedia
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "psocialmedia".tr,
                            style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'redex'),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "psocialmediaex".tr,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'dubai'),
                          ),
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          Checkbox(
                            value: facebookcheck,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: ((value) {
                              setState(() {
                                facebookcheck = value!;
                              });
                            }),
                            activeColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.facebook,
                            color:
                                facebookcheck ? Colors.blueAccent : Colors.grey,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: socialmediaFiled(
                                TextInputType.text,
                                Iconsax.call,
                                "https://facebook.com/username",
                                facebookcheck,
                                facebookcontroller,
                                facebookvalid,
                                "emptyfield".tr),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          Checkbox(
                            value: telegramcheck,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: ((value) {
                              setState(() {
                                telegramcheck = value!;
                              });
                            }),
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.telegram,
                            color: telegramcheck ? Colors.blue : Colors.grey,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: socialmediaFiled(
                                TextInputType.text,
                                Iconsax.call,
                                "https://telegram.me/username",
                                telegramcheck,
                                telegramcontroller,
                                telegramavalid,
                                "emptyfield".tr),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          Checkbox(
                            value: whatsappcheck,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: ((value) {
                              setState(() {
                                whatsappcheck = value!;
                              });
                            }),
                            activeColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: whatsappcheck ? secondaryColor : Colors.grey,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: socialmediaFiled(
                                TextInputType.number,
                                Iconsax.call,
                                "https://wa.me/+9647700000000",
                                whatsappcheck,
                                whatsappcontroller,
                                whatsappvalid,
                                "emptyfield".tr),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          Checkbox(
                            value: instagramcheck,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: ((value) {
                              setState(() {
                                instagramcheck = value!;
                              });
                            }),
                            activeColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.instagram,
                            color: instagramcheck ? Colors.red : Colors.grey,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: socialmediaFiled(
                                TextInputType.text,
                                Iconsax.call,
                                "https://instagram.com/username",
                                instagramcheck,
                                instagramcontroller,
                                instagramvalid,
                                "emptyfield".tr),
                          ),
                        ],
                      ),
                    ),
                  ],
                  //! check terms
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: Checkbox(
                          value: termscheck,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: ((value) {
                            setState(() {
                              termscheck = value!;
                            });
                          }),
                          activeColor: const Color(0xff0FD481),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text("${"pcheckterms".tr} ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/terms");
                        },
                        child: Text("${"terms".tr} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff0FD481),
                            )),
                      ),
                      Text("pcheckterms2".tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //! submit button
                  !loading
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: secondaryColor.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                    1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (namecontroller.text.isNotEmpty &&
                                  namecontroller.text.length >= 3) {
                                setState(() {
                                  namevalid = false;
                                });
                              } else {
                                setState(() {
                                  namevalid = true;
                                });
                              }
                              if (shortlocationcontroller.text.isNotEmpty) {
                                setState(() {
                                  shortlocationvalid = false;
                                });
                              } else {
                                setState(() {
                                  shortlocationvalid = true;
                                });
                              }
                              if (descriptioncontroller.text.isNotEmpty &&
                                  descriptioncontroller.text.length >= 20) {
                                setState(() {
                                  descriptionvalid = false;
                                });
                              } else {
                                setState(() {
                                  descriptionvalid = true;
                                });
                              }

                              if (phonecontroller.text.isNotEmpty &&
                                  phonecontroller.text.isNumericOnly) {
                                setState(() {
                                  phonevalid = false;
                                });
                              } else {
                                setState(() {
                                  phonevalid = true;
                                });
                              }
                              //! check social media and price and avilable
                              if (selectedtype == "stayplace") {
                                if (avilablecontroller.text.isNotEmpty &&
                                    avilablecontroller.text.length >= 3) {
                                  setState(() {
                                    avilablevalid = false;
                                  });
                                } else {
                                  setState(() {
                                    avilablevalid = true;
                                  });
                                }
                                if (pricecontroller.text.isNotEmpty) {
                                  setState(() {
                                    pricevaild = false;
                                  });
                                } else {
                                  setState(() {
                                    pricevaild = true;
                                  });
                                }
                              } else {
                                if (facebookcheck) {
                                  if (facebookcontroller.text.isNotEmpty &&
                                      facebookUrlPattern
                                          .hasMatch(facebookcontroller.text)) {
                                    setState(() {
                                      facebookvalid = false;
                                    });
                                  } else {
                                    setState(() {
                                      facebookvalid = true;
                                    });
                                  }
                                }
                                if (whatsappcheck) {
                                  if (whatsappcontroller.text.isNotEmpty &&
                                      whatsappcontroller.text.isPhoneNumber &&
                                      whatsappcontroller.text.isNumericOnly) {
                                    setState(() {
                                      whatsappvalid = false;
                                    });
                                  } else {
                                    setState(() {
                                      whatsappvalid = true;
                                    });
                                  }
                                }
                                if (instagramcheck) {
                                  if (instagramcontroller.text.isNotEmpty &&
                                      instagramUrlPattern
                                          .hasMatch(instagramcontroller.text)) {
                                    setState(() {
                                      instagramvalid = false;
                                    });
                                  } else {
                                    setState(() {
                                      instagramvalid = true;
                                    });
                                  }
                                }
                                if (telegramcheck) {
                                  if (telegramcontroller.text.isNotEmpty &&
                                      telegramUrlPattern
                                          .hasMatch(telegramcontroller.text)) {
                                    setState(() {
                                      telegramavalid = false;
                                    });
                                  } else {
                                    setState(() {
                                      telegramavalid = true;
                                    });
                                  }
                                }
                              }

                              //! check if all valid
                              if (selectedtype == "stayplace") {
                                if (!namevalid &&
                                    !phonevalid &&
                                    !descriptionvalid &&
                                    !shortlocationvalid &&
                                    !pricevaild &&
                                    !phonevalid) {
                                  if (termscheck == false) {
                                    Get.snackbar("reviewerrortitle".tr,
                                        "youmustagree".tr,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.7),
                                        icon: const Icon(
                                          FontAwesomeIcons.circleExclamation,
                                          color: Colors.red,
                                        ));
                                  } else {
                                    Get.dialog(AlertDialog(
                                      elevation: 0,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            color: secondaryColor,
                                            size: 60,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "paddnew".tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "areyousure2".tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "importnote".tr,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "redex"),
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: secondaryColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "no".tr,
                                                      style: const TextStyle(
                                                        color: secondaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    Get.back();
                                                    loading = true;
                                                  });
                                                  Future.sync(() =>
                                                      merchantController
                                                          .addplace(
                                                        namecontroller.text,
                                                        descriptioncontroller
                                                            .text,
                                                        phonecontroller.text,
                                                        int.parse(
                                                            pricecontroller
                                                                .text),
                                                        avilablecontroller.text,
                                                        "string",
                                                        "string",
                                                        "string",
                                                        instagramcontroller
                                                            .text,
                                                        shortlocationcontroller
                                                            .text,
                                                        "$latitude,$logitude",
                                                        selectedcityId,
                                                        selectedtype,
                                                        selectedSubtype ==
                                                                "notfounds"
                                                            ? ""
                                                            : selectedSubtype,
                                                      )).then((value) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (value == "done") {
                                                      Get.back();

                                                      Get.snackbar(
                                                        "placeaddsuc".tr,
                                                        '',
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.7),
                                                        colorText: Colors.white,
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .check,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        backgroundGradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Colors.teal,
                                                              Colors.green,
                                                            ]),
                                                      );
                                                    } else {
                                                      Get.snackbar(
                                                          "reviewerrortitle".tr,
                                                          "placeadderr".tr,
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.7),
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .circleExclamation,
                                                            color: Colors.red,
                                                          ));
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "yes".tr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ));
                                  }
                                }
                              } else {
                                if (!namevalid &&
                                    !phonevalid &&
                                    !descriptionvalid &&
                                    !shortlocationvalid &&
                                    !whatsappvalid &&
                                    !telegramavalid &&
                                    !facebookvalid &&
                                    !instagramvalid) {
                                  if (termscheck == false) {
                                    Get.snackbar("reviewerrortitle".tr,
                                        "youmustagree".tr,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.7),
                                        icon: const Icon(
                                          FontAwesomeIcons.circleExclamation,
                                          color: Colors.red,
                                        ));
                                  } else {
                                    Get.dialog(AlertDialog(
                                      elevation: 0,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.penToSquare,
                                            color: secondaryColor,
                                            size: 60,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "paddnew".tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "areyousure2".tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "importnote".tr,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "redex"),
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: secondaryColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "no".tr,
                                                      style: const TextStyle(
                                                        color: secondaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    Get.back();
                                                    loading = true;
                                                  });
                                                  Future.sync(() =>
                                                      merchantController
                                                          .addplace(
                                                        namecontroller.text,
                                                        descriptioncontroller
                                                            .text,
                                                        phonecontroller.text,
                                                        0,
                                                        "string",
                                                        facebookcontroller
                                                                    .text ==
                                                                ""
                                                            ? "string"
                                                            : facebookcontroller
                                                                .text,
                                                        telegramcontroller
                                                                    .text ==
                                                                ""
                                                            ? "string"
                                                            : telegramcontroller
                                                                .text,
                                                        whatsappcontroller
                                                                    .text ==
                                                                ""
                                                            ? "string"
                                                            : whatsappcontroller
                                                                .text,
                                                        instagramcontroller
                                                                    .text ==
                                                                ""
                                                            ? "string"
                                                            : instagramcontroller
                                                                .text,
                                                        shortlocationcontroller
                                                            .text,
                                                        "$latitude,$logitude",
                                                        selectedcityId,
                                                        selectedtype,
                                                        selectedSubtype ==
                                                                "notfounds"
                                                            ? ""
                                                            : selectedSubtype,
                                                      )).then((value) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (value == "done") {
                                                      Get.back();

                                                      Get.snackbar(
                                                        "placeaddsuc".tr,
                                                        '',
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.7),
                                                        colorText: Colors.white,
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .check,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        backgroundGradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Colors.teal,
                                                              Colors.green,
                                                            ]),
                                                      );
                                                    } else {
                                                      Get.snackbar(
                                                          "reviewerrortitle".tr,
                                                          "placeadderr".tr,
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.7),
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .circleExclamation,
                                                            color: Colors.red,
                                                          ));
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "yes".tr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ));
                                  }
                                }
                              }
                            },
                            child: Text("addplacenow".tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: "redex",
                                )),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: secondaryColor.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: const Offset(
                                    1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: LoadingAnimationWidget.inkDrop(
                              color: const Color(0xff0FD481),
                              size: 30,
                            ),
                          )),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField cTextFiled(TextInputType textInputType, IconData icon,
      TextEditingController controller, bool valid, String errorText) {
    return TextField(
      keyboardType: textInputType,
      maxLines: null,
      cursorColor: secondaryColor,
      controller: controller,
      inputFormatters: textInputType == TextInputType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelText: "",
        hintText: "",
        errorText: valid ? errorText : null,
        suffix: icon == Iconsax.dollar_circle
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "IQD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "redex"),
                ),
              )
            : null,
        prefixIcon: icon == Iconsax.dollar_circle
            ? null
            : Icon(
                icon,
                color: Colors.black,
                size: 20,
              ),
        alignLabelWithHint: true,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItems(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  Widget socialmediaFiled(
      TextInputType textInputType,
      IconData icon,
      String prefix,
      bool checked,
      TextEditingController controller,
      bool valid,
      String errorText) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextField(
        keyboardType: textInputType,
        maxLines: null,
        cursorColor: secondaryColor,
        controller: controller,
        enabled: checked,
        inputFormatters: textInputType == TextInputType.number
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        style: TextStyle(
          fontSize: 14,
          color: checked ? Colors.black : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          labelText: "",
          hintText: prefix,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: valid
              ? OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                )
              : OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
