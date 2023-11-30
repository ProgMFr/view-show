import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:guide/views/colors.dart';
import 'package:guide/views/local_vars.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());
  MerchantController merchantController = Get.put(MerchantController());
  int i = 0;
  bool isloading = false;
  bool isMerchant = false;
  @override
  void initState() {
    Future.sync(() => profileController.getProfile()).then((value) {
      if (value == true) {
        if (mounted) {
          setState(() {
            isMerchant = true;
            merchantController.getPlace();
          });
        }
      }
    });

    super.initState();
  }

  Future pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    var imageTemp = File(image.path);
    Get.dialog(
      AlertDialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "changeprofilepic".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff0FD481),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                image: DecorationImage(
                  image: FileImage(imageTemp),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    pickImage();
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: const Color(0xff0FD481), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "changepic".tr,
                        style: const TextStyle(
                          color: Color(0xff0FD481),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.showOverlay(
                      asyncFunction: () async {
                        await profileController.uploadImage(imageTemp);
                      },
                      loadingWidget: Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: const Color(0xff0FD481),
                          size: 50,
                        ),
                      ),
                      opacity: 0.1,
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xff0FD481),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "savepic".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => profileController.profileInfo.isEmpty
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xff0FD481),
                  size: 50,
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "navprofile".tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'redex',
                          ),
                        ),
                      ),
                      if (profileController.profileInfo[0].isMerchant ==
                          true) ...[
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.deepOrange,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.userTie,
                                    color: Colors.deepOrange,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "ismerchant".tr,
                                    style: const TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.blueGrey[700]!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.calendarDay,
                                    color: Colors.blueGrey[700],
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    profileController
                                            .profileInfo[0].dayToExpire +
                                        "daytoexpire".tr,
                                    style: TextStyle(
                                      color: Colors.blueGrey[700],
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      userConatiner(),
                      const SizedBox(
                        height: 20,
                      ),
                      profileAction("editprofile", FontAwesomeIcons.userPen,
                          const Color(0xff0FD481), () {
                        Get.toNamed("/editprofile");
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      profileAction("pchangepass", FontAwesomeIcons.lock,
                          const Color(0xff0FD481), () {
                        Get.toNamed("/changepassword");
                      }),
                      const SizedBox(
                        height: 25,
                      ),
                      profileAction("bookmark", FontAwesomeIcons.solidBookmark,
                          Colors.orange, () {
                        Get.toNamed("/userbookmarks");
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      profileAction(
                          "myreview",
                          FontAwesomeIcons.solidCommentDots,
                          Colors.deepPurple, () {
                        Get.toNamed("/userreview");
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      isMerchant
                          ? (merchantController.placeInfo.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: LoadingAnimationWidget.inkDrop(
                                    color: const Color(0xff0FD481),
                                    size: 50,
                                  ),
                                )
                              : (merchantController.placeInfo[0] ==
                                          "noplaceyet" ||
                                      merchantController.placeInfo[0] == "error"
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "busactive".tr,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: const SizedBox(
                                                width: double.infinity,
                                                height: 100,
                                                child: BlurHash(
                                                  hash:
                                                      // "QEG}XX=W1HF3FqV|E*OTOE}HO9E#=2s*NdsDk8SN0}Ab\$\$\$L,bs+\$gjasA",
                                                      "LB44+pL#S[t8HXy?oiRi%5ScVrt8",
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("noplaceyet".tr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          "/merchantaddplace");
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 6),
                                                      child: Text(
                                                          "clicktoaddplace".tr,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "busactive".tr,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: const DecorationImage(
                                              image: BlurHashImage(
                                                "LB44+pL#S[t8HXy?oiRi%5ScVrt8",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: secondaryColor
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              merchantController.placeInfo[0]
                                                      .placeImages.isEmpty
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.white,
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5,
                                                          vertical: 3),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const FaIcon(
                                                            FontAwesomeIcons
                                                                .solidImages,
                                                            color: Colors.red,
                                                            size: 15,
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            "pimagesempty".tr,
                                                            style:
                                                                const TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              placeContainer(
                                                  merchantController
                                                      .placeInfo[0],
                                                  true,
                                                  fromprofile: true),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            "/addimages");
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const FaIcon(
                                                              FontAwesomeIcons
                                                                  .image,
                                                              color: Colors.red,
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text("editimage".tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            "/merchanteditplace");
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: secondaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const FaIcon(
                                                              FontAwesomeIcons
                                                                  .solidPenToSquare,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text("editinfo".tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))
                          : merchianAd(() {}),
                      const SizedBox(
                        height: 20,
                      ),
                      profileAction(
                          "logout".tr,
                          FontAwesomeIcons.arrowRightFromBracket,
                          Colors.red, () {
                        Get.dialog(AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.arrowRightFromBracket,
                                color: Colors.red,
                                size: 60,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "logout".tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "areyousure".tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                              color: Colors.red, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "no".tr,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Get.showOverlay(
                                        asyncFunction: () async {
                                          var result =
                                              await profileController.logout();
                                          if (result == "done") {
                                            setState(() {
                                              appdataprefs!
                                                  .setString('token', "");
                                              appdataprefs!
                                                  .setBool('islogin', false);

                                              Get.offNamedUntil(
                                                  '/login', (route) => false);
                                            });
                                            Get.back();
                                          } else {
                                            Get.back();
                                            Get.snackbar(
                                                "error".tr, "error".tr);
                                          }
                                        },
                                        loadingWidget: Center(
                                          child: LoadingAnimationWidget.inkDrop(
                                            color: const Color(0xff0FD481),
                                            size: 50,
                                          ),
                                        ),
                                        opacity: 0.1,
                                      );
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "yes".tr,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ));
                      }),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )));
  }

  GestureDetector profileAction(
      String title, IconData icon, Color color, Function function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: color,
              size: 18,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(title.tr,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Stack userConatiner() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const SizedBox(
            height: 105,
            width: double.infinity,
            child: BlurHash(
                hash: "P21Nt0VXQRkYVEbco\$iwQ8kqk?Z~abjEkCkXHXkrt.aJu6kCV=g4"),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 105,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: profileController.profileInfo[0].imageUrl == null
                          ? Image.asset("assest/images/user.png",
                              fit: BoxFit.cover)
                          : CachedNetworkImage(
                              imageUrl:
                                  profileController.profileInfo[0].imageUrl!,
                              placeholder: (context, url) {
                                return const BlurHash(
                                  hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
                                );
                              },
                              fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xfff5f6f9),
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          pickImage();
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.camera,
                          color: Colors.black87,
                          size: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.fromLTRB(10, 0, 10, 5),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const FaIcon(
                            FontAwesomeIcons.solidUser,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${profileController.profileInfo[0].firstName} ${profileController.profileInfo[0].lastName}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (profileController.profileInfo[0].isMerchant) ...{
                            const SizedBox(width: 5),
                            Image.asset("assest/images/check.png",
                                width: 17, height: 17),
                          }
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const FaIcon(
                            FontAwesomeIcons.solidEnvelope,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${profileController.profileInfo[0].email}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const FaIcon(
                            FontAwesomeIcons.phoneFlip,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "0${profileController.profileInfo[0].phoneNumber}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget merchianAd(Function function) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        // margin: const EdgeInsets.only(left: 15),
        //mediaQuery.size.width * 0.8
        width: double.infinity,
        height: 110,
        // height: ,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assest/images/merchainad.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  // padding: EdgeInsets.zero,
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "merchainadtitle".tr,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        textAlign: TextAlign.center,
                        "merchainadtext".tr,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.2,
                          overflow: TextOverflow.fade,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          // url luncher
                          var text =
                              '''السلام عليكم ارغب بتغيير حسابي الى نشاط تجاري وهذه معلومات حسابي:
الاسم : *${appdataprefs!.getString("fname")} ${appdataprefs!.getString("lname")}*
الايميل : ```${appdataprefs!.getString("email")}```
رقم الهاتف : ```${appdataprefs!.getString("phone")}```
*ارسل الرسالة كما هي بدون تعديل*'''; //+92xx enter like this
                          var whatsappURLIos =
                              "https://wa.me/+$paymentPhone?text=${Uri.tryParse(text)}";
                          // await launchUrl(Uri.parse(whatsappURlAndroid));
                          var whatsappURlAndroid =
                              "https://wa.me/+$paymentPhone?text=$text";

                          if (Platform.isAndroid) {
                            launchUrl(Uri.parse(whatsappURlAndroid),
                                mode: LaunchMode.externalApplication);
                          } else {
                            launchUrl(Uri.parse(whatsappURLIos),
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          width: 180,
                          height: 30,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.25),
                          ),
                          child: Text(
                            "merchainadbutton".tr,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
