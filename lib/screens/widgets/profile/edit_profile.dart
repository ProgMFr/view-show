import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/profile_controller.dart';
import 'package:guide/views/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController profileController = Get.find();
  int phonenumber = 0;
  bool fnamevalid = false;
  bool lnamevalid = false;
  bool emailvalid = false;
  bool phonevalid = false;
  bool loading = false;
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  @override
  void initState() {
    fnamecontroller.text = profileController.profileInfo[0].firstName;
    lnamecontroller.text = profileController.profileInfo[0].lastName;
    emailcontroller.text = profileController.profileInfo[0].email;
    phonecontroller.text =
        profileController.profileInfo[0].phoneNumber.toString();
    super.initState();
  }

  Future pick2Image() async {
    var image2 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image2 == null) return;
    var imageTemp2 = File(image2.path);
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
                  image: FileImage(imageTemp2),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(1, 1), // changes position of shadow
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
                    pick2Image();
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
                        await profileController.uploadImage(imageTemp2);
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
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return profileController.getProfile();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("editprofile".tr,
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
          () => profileController.profileInfo.isEmpty
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
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:
                                    profileController.profileInfo[0].imageUrl ==
                                            null
                                        ? Image.asset("assest/images/user.png",
                                            fit: BoxFit.cover)
                                        : CachedNetworkImage(
                                            imageUrl: profileController
                                                .profileInfo[0].imageUrl!,
                                            fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: secondaryColor,
                                ),
                                child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    pick2Image();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Flexible(
                                child: cTextFiled(
                                    TextInputType.text,
                                    "fname".tr,
                                    "",
                                    Iconsax.profile_circle,
                                    fnamecontroller,
                                    fnamevalid,
                                    "namevalidation".tr),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: cTextFiled(
                                    TextInputType.text,
                                    "lname".tr,
                                    "",
                                    Iconsax.profile_circle,
                                    lnamecontroller,
                                    lnamevalid,
                                    "namevalidation".tr),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        cTextFiled(
                            TextInputType.emailAddress,
                            "email".tr,
                            "",
                            Iconsax.sms,
                            emailcontroller,
                            emailvalid,
                            "emailvalidation".tr),
                        const SizedBox(
                          height: 20,
                        ),
                        cTextFiled(
                            TextInputType.number,
                            "phonenum".tr,
                            "",
                            Iconsax.call,
                            phonecontroller,
                            phonevalid,
                            "phonevalidation".tr),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  fnamecontroller.text = profileController
                                      .profileInfo[0].firstName;
                                  lnamecontroller.text =
                                      profileController.profileInfo[0].lastName;
                                  emailcontroller.text =
                                      profileController.profileInfo[0].email;
                                  phonecontroller.text = profileController
                                      .profileInfo[0].phoneNumber
                                      .toString();
                                });
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
                                if (fnamecontroller.text.isNotEmpty &&
                                    fnamecontroller.text.length >= 3) {
                                  setState(() {
                                    fnamevalid = false;
                                  });
                                } else {
                                  setState(() {
                                    fnamevalid = true;
                                  });
                                }
                                if (lnamecontroller.text.isNotEmpty &&
                                    lnamecontroller.text.length >= 3) {
                                  setState(() {
                                    lnamevalid = false;
                                  });
                                } else {
                                  setState(() {
                                    lnamevalid = true;
                                  });
                                }
                                if (emailcontroller.text.isNotEmpty &&
                                    emailcontroller.text.isEmail) {
                                  setState(() {
                                    emailvalid = false;
                                  });
                                } else {
                                  setState(() {
                                    emailvalid = true;
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

                                if (!emailvalid &&
                                    !fnamevalid &&
                                    !lnamevalid &&
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
                                          "editprofile".tr,
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
                                                        profileController
                                                            .editProfile(
                                                                fnamecontroller
                                                                    .text,
                                                                lnamecontroller
                                                                    .text,
                                                                emailcontroller
                                                                    .text,
                                                                phonecontroller
                                                                    .text))
                                                    .then((value) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  if (value == "done") {
                                                    Get.snackbar(
                                                      "editsuccess".tr,
                                                      '',
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.7),
                                                      colorText: Colors.white,
                                                      icon: const Icon(
                                                        FontAwesomeIcons.check,
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
                                                  } else if (value ==
                                                      "phoneexist") {
                                                    Get.snackbar(
                                                        "reviewerrortitle".tr,
                                                        "phoneexist".tr,
                                                        colorText: Colors.white,
                                                        messageText: Row(
                                                          children: [
                                                            const Icon(
                                                              Iconsax.call,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "phoneexist".tr,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.7),
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .circleExclamation,
                                                          color: Colors.red,
                                                        ));
                                                  } else if (value ==
                                                      "emailexist") {
                                                    Get.snackbar(
                                                        "reviewerrortitle".tr,
                                                        "emailexist".tr,
                                                        messageText: Row(
                                                          children: [
                                                            const Icon(
                                                              Iconsax.sms,
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "emailexist".tr,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.7),
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .circleExclamation,
                                                          color: Colors.red,
                                                        ));
                                                  } else {
                                                    Get.snackbar(
                                                        "reviewerrortitle".tr,
                                                        "error".tr,
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.7),
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
                                      "editprofile".tr,
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

  TextField cTextFiled(
      TextInputType textInputType,
      String labelText,
      String hintText,
      IconData icon,
      TextEditingController controller,
      bool valid,
      String errorText) {
    return TextField(
      keyboardType: textInputType,
      inputFormatters: textInputType == TextInputType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        errorText: valid ? errorText : null,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
        prefixIcon: Icon(
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
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
