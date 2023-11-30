import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/profile_controller.dart';
import 'package:guide/views/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MerchantEditPlace extends StatefulWidget {
  const MerchantEditPlace({super.key});

  @override
  State<MerchantEditPlace> createState() => _MerchantEditPlaceState();
}

class _MerchantEditPlaceState extends State<MerchantEditPlace> {
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
  bool phonevalid = false;
  bool whatsappvalid = false;
  bool telegramavalid = false;
  bool facebookvalid = false;
  bool instagramvalid = false;
  bool whatsappcheck = false;
  bool telegramcheck = false;
  bool facebookcheck = false;
  bool instagramcheck = false;
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

  @override
  void initState() {
    namecontroller.text = merchantController.placeInfo[0].name;
    if (merchantController.placeInfo[0].type == "stayplace") {
      pricecontroller.text = merchantController.placeInfo[0].price.toString();
      avilablecontroller.text =
          merchantController.placeInfo[0].available.toString();
    }

    phonecontroller.text =
        merchantController.placeInfo[0].phoneNumber.toString();
    descriptioncontroller.text = merchantController.placeInfo[0].description;
    if (merchantController.placeInfo[0].socialMedia != null) {
      telegramcontroller.text =
          merchantController.placeInfo[0].socialMedia!.telegram ?? "";
      whatsappcontroller.text =
          merchantController.placeInfo[0].socialMedia!.whatsapp ?? "";
      facebookcontroller.text =
          merchantController.placeInfo[0].socialMedia!.facebook ?? "";
      instagramcontroller.text =
          merchantController.placeInfo[0].socialMedia!.instagram ?? "";
      if (merchantController.placeInfo[0].socialMedia!.telegram != null) {
        telegramcheck = true;
      }
      if (merchantController.placeInfo[0].socialMedia!.whatsapp != null) {
        whatsappcheck = true;
      }
      if (merchantController.placeInfo[0].socialMedia!.facebook != null) {
        facebookcheck = true;
      }
      if (merchantController.placeInfo[0].socialMedia!.instagram != null) {
        instagramcheck = true;
      }
    }

    super.initState();
  }

  void undo() {
    setState(() {
      namecontroller.text = merchantController.placeInfo[0].name;

      pricecontroller.text =
          merchantController.placeInfo[0].price.toInt().toString();
      avilablecontroller.text = merchantController.placeInfo[0].available;
      phonecontroller.text =
          merchantController.placeInfo[0].phoneNumber.toString();
      descriptioncontroller.text = merchantController.placeInfo[0].description;
      if (merchantController.placeInfo[0].socialMedia != null) {
        telegramcontroller.text =
            merchantController.placeInfo[0].socialMedia!.telegram ?? "";
        whatsappcontroller.text =
            merchantController.placeInfo[0].socialMedia!.whatsapp ?? "";
        facebookcontroller.text =
            merchantController.placeInfo[0].socialMedia!.facebook ?? "";
        instagramcontroller.text =
            merchantController.placeInfo[0].socialMedia!.instagram ?? "";
        if (merchantController.placeInfo[0].socialMedia!.telegram != null) {
          telegramcheck = true;
        }
        if (merchantController.placeInfo[0].socialMedia!.whatsapp != null) {
          whatsappcheck = true;
        }
        if (merchantController.placeInfo[0].socialMedia!.facebook != null) {
          facebookcheck = true;
        }
        if (merchantController.placeInfo[0].socialMedia!.instagram != null) {
          instagramcheck = true;
        }
      }
      namevalid = false;
      pricevaild = false;
      avilablevalid = false;
      descriptionvalid = false;
      phonevalid = false;
      whatsappvalid = false;
      telegramavalid = false;
      facebookvalid = false;
      instagramvalid = false;
    });
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("editinfo".tr,
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
            child: Obx(
          () => merchantController.placeInfo.isEmpty
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xff0FD481),
                    size: 50,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
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
                        cTextFiled(
                            TextInputType.emailAddress,
                            Iconsax.sms,
                            namecontroller,
                            namevalid,
                            "placenamevalidation".tr),
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
                        if (merchantController.placeInfo[0].type ==
                            "stayplace") ...[
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
                          cTextFiled(
                              TextInputType.number,
                              Iconsax.dollar_circle,
                              pricecontroller,
                              pricevaild,
                              "phonevalidation".tr),
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
                          cTextFiled(
                              TextInputType.text,
                              Iconsax.calendar_tick,
                              avilablecontroller,
                              avilablevalid,
                              "emptyfield".tr)
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
                                  color: facebookcheck
                                      ? Colors.blueAccent
                                      : Colors.grey,
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
                                  color:
                                      telegramcheck ? Colors.blue : Colors.grey,
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
                                  color: whatsappcheck
                                      ? secondaryColor
                                      : Colors.grey,
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
                                  color:
                                      instagramcheck ? Colors.red : Colors.grey,
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
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                undo();
                              },
                              height: 40,
                              minWidth: 150,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Color(0xff0DB770),
                                    width: 2,
                                  )),
                              child: Text(
                                "undo".tr,
                                style: const TextStyle(
                                    color: Color(0xff0DB770), fontSize: 20.0),
                              ),
                            ),
                            MaterialButton(
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
                                    phonecontroller.text.isPhoneNumber &&
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
                                if (merchantController.placeInfo[0].type ==
                                    "stayplace") {
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
                                        facebookUrlPattern.hasMatch(
                                            facebookcontroller.text)) {
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
                                        instagramUrlPattern.hasMatch(
                                            instagramcontroller.text)) {
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
                                        telegramUrlPattern.hasMatch(
                                            telegramcontroller.text)) {
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
                                if (merchantController.placeInfo[0].type ==
                                    "stayplace") {
                                  if (!namevalid &&
                                      !phonevalid &&
                                      !descriptionvalid &&
                                      !pricevaild &&
                                      !phonevalid) {
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
                                            "editinfo".tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "areyousure".tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
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
                                                      merchantController.editplace(
                                                          namecontroller.text,
                                                          descriptioncontroller
                                                              .text,
                                                          phonecontroller.text,
                                                          int.parse(
                                                              pricecontroller
                                                                  .text),
                                                          avilablecontroller
                                                              .text,
                                                          facebookcontroller
                                                              .text,
                                                          telegramcontroller
                                                              .text,
                                                          whatsappcontroller
                                                              .text,
                                                          instagramcontroller
                                                              .text)).then(
                                                      (value) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (value == "done") {
                                                      Get.snackbar(
                                                        "تم تعديل المعلومات بنجاح"
                                                            .tr,
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
                                                          "error".tr,
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
                                } else {
                                  if (!namevalid &&
                                      !phonevalid &&
                                      !descriptionvalid &&
                                      !whatsappvalid &&
                                      !telegramavalid &&
                                      !facebookvalid &&
                                      !instagramvalid) {
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
                                            "editinfo".tr,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "areyousure".tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
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
                                                      merchantController.editplace(
                                                          namecontroller.text,
                                                          descriptioncontroller
                                                              .text,
                                                          phonecontroller.text,
                                                          0,
                                                          avilablecontroller
                                                              .text,
                                                          facebookcontroller
                                                              .text,
                                                          telegramcontroller
                                                              .text,
                                                          whatsappcontroller
                                                              .text,
                                                          instagramcontroller
                                                              .text)).then(
                                                      (value) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (value == "done") {
                                                      Get.snackbar(
                                                        "تم تعديل المعلومات بنجاح"
                                                            .tr,
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
                                                          "error".tr,
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
                              },
                              height: 40,
                              minWidth: 150,
                              color: loading
                                  ? Colors.white
                                  : const Color(0xff0DB770),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: loading
                                  ? LoadingAnimationWidget.inkDrop(
                                      color: const Color(0xff0FD481),
                                      size: 30,
                                    )
                                  : Text(
                                      "editinfo".tr,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        )),
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
