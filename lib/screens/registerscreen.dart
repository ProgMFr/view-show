import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController controller = Get.put(RegisterController());
  late RiveAnimationController thumbcontroller;
  int phonenumber = 0;
  bool fnamevalid = false;
  bool lnamevalid = false;
  bool emailvalid = false;
  bool phonevalid = false;
  bool passwordvalid = false;
  bool password2valid = false;
  bool loading = false;

  TextEditingController phonecontroller = TextEditingController();
  TextEditingController password2controller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  @override
  void initState() {
    thumbcontroller = SimpleAnimation("animationName");
    super.initState();
  }

  @override
  void dispose() {
    thumbcontroller.isActive = false;
    thumbcontroller.dispose();
    super.dispose();
  }

  Future register() async {
    if (phonecontroller.text.startsWith("0")) {
      phonenumber = int.parse(phonecontroller.text.replaceFirst("0", ""));
    } else {
      phonenumber = int.parse(phonecontroller.text);
    }
    return await controller.registerbutton(
        fnamecontroller.text,
        lnamecontroller.text,
        emailcontroller.text,
        phonenumber,
        password1controller.text,
        password2controller.text);
    // fname = fnamecontroller.text;
    // lname = lnamecontroller.text;
    // email = emailcontroller.text;
    // try {
    //   phonenumber = int.parse(phonecontroller.text);
    // } catch (e) {
    //   print(e);
    // }

    // if (password.isNotEmpty) {
    //   var response = await controller.registerbutton(
    //       fname, lname, email, phonenumber, password, password);
    //   print(response);
    //   if (response != false) {
    //     Get.toNamed("/home");
    //   } else {

    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFd0f2eb),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // video background
                Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(0xFFd0f2eb),
                  child: RiveAnimation.asset(
                    'assest/rive/travel_icons_pack.riv',
                    controllers: [thumbcontroller],
                  ),
                ),
                // register form
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.black,
                        padding:
                            const EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: appdataprefs!.getString("language") == "en"
                                  ? 160
                                  : 85,
                              height:
                                  appdataprefs!.getString("language") == "en"
                                      ? 70
                                      : 85,
                              alignment: Alignment.center,
                              // color: Colors.red,
                              child: appdataprefs!.getString("language") == "en"
                                  ? Image.asset("assest/images/logo4.png")
                                  : Image.asset(
                                      "assest/images/arabiclogo.png",
                                    ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: appdataprefs!.getString("language") ==
                                            "en"
                                        ? 10
                                        : 0),
                                // color: Colors.greenAccent,
                                alignment: Alignment.center,
                                // height: 90,
                                // width:
                                //     appdataprefs!.getString("language") == "en"
                                //         ? 180
                                //         : 220,
                                child: Center(
                                  child: Text(
                                    'registertitle'.tr,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: const Color(0xff0DB770),
                                        fontSize: appdataprefs!
                                                    .getString("language") ==
                                                "en"
                                            ? 19
                                            : 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //form items
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          children: [
                            Row(
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
                            const SizedBox(
                              height: 20,
                            ),
                            cTextFiled(
                                TextInputType.emailAddress,
                                "email".tr,
                                "user@example.com",
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
                                "07701234567",
                                Iconsax.call,
                                phonecontroller,
                                phonevalid,
                                "phonevalidation".tr),
                            const SizedBox(
                              height: 20,
                            ),
                            cTextFiled(
                                TextInputType.visiblePassword,
                                "password".tr,
                                "passwordhint".tr,
                                Iconsax.lock,
                                password1controller,
                                passwordvalid,
                                "passwordhint".tr),
                            const SizedBox(
                              height: 20,
                            ),
                            cTextFiled(
                                TextInputType.visiblePassword,
                                "confirmpassword".tr,
                                "confpasswordhint".tr,
                                Iconsax.lock,
                                password2controller,
                                password2valid,
                                "passwordvalidation".tr),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (fnamecontroller.text.isNotEmpty &&
                                    fnamecontroller.text.length >= 3 &&
                                    fnamecontroller.text.length <= 12) {
                                  setState(() {
                                    fnamevalid = false;
                                  });
                                } else {
                                  setState(() {
                                    fnamevalid = true;
                                  });
                                }
                                if (lnamecontroller.text.isNotEmpty &&
                                    lnamecontroller.text.length >= 3 &&
                                    lnamecontroller.text.length <= 12) {
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
                                if (password1controller.text.isNotEmpty &&
                                    password1controller.text.length >= 8) {
                                  setState(() {
                                    passwordvalid = false;
                                  });
                                  if (password1controller.text ==
                                      password2controller.text) {
                                    setState(() {
                                      password2valid = false;
                                    });
                                  } else {
                                    setState(() {
                                      password2valid = true;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    passwordvalid = true;
                                  });
                                }
                                if (!emailvalid &&
                                    !fnamevalid &&
                                    !lnamevalid &&
                                    !phonevalid &&
                                    !passwordvalid &&
                                    !password2valid) {
                                  setState(() {
                                    loading = true;
                                  });
                                  Future.sync(() => register()).then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                    if (value == "done") {
                                      Get.dialog(
                                        WillPopScope(
                                          onWillPop: () async => false,
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            contentPadding: EdgeInsets.zero,
                                            actionsPadding: EdgeInsets.zero,
                                            buttonPadding: EdgeInsets.zero,
                                            insetPadding: EdgeInsets.zero,
                                            content: SizedBox(
                                              height: 360,
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assest/images/registerdone.jpg",
                                                    height: 220,
                                                    width: 220,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 250,
                                                    child: Text(
                                                      "success".tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Color(0xff0DB770),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  MaterialButton(
                                                    color:
                                                        const Color(0xff0DB770),
                                                    onPressed: () {
                                                      Get.offNamedUntil(
                                                          '/login',
                                                          (route) => false);
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    child: Text(
                                                      "login".tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        barrierDismissible: false,
                                      );
                                    } else if (value == "phoneexist") {
                                      Get.snackbar("reviewerrortitle".tr,
                                          "phoneexist".tr,
                                          colorText: Colors.white,
                                          messageText: Row(
                                            children: [
                                              const Icon(
                                                Iconsax.call,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "phoneexist".tr,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.7),
                                          icon: const Icon(
                                            FontAwesomeIcons.circleExclamation,
                                            color: Colors.red,
                                          ));
                                    } else if (value == "emailexist") {
                                      Get.snackbar("reviewerrortitle".tr,
                                          "emailexist".tr,
                                          messageText: Row(
                                            children: [
                                              const Icon(
                                                Iconsax.sms,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "emailexist".tr,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.7),
                                          icon: const Icon(
                                            FontAwesomeIcons.circleExclamation,
                                            color: Colors.red,
                                          ));
                                    } else {
                                      Get.snackbar(
                                          "reviewerrortitle".tr, "error".tr,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.7),
                                          icon: const Icon(
                                            FontAwesomeIcons.circleExclamation,
                                            color: Colors.red,
                                          ));
                                    }
                                  });
                                }
                              },
                              height: 45,
                              color: loading
                                  ? Colors.white
                                  : const Color(0xff0DB770),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: loading
                                  ? LoadingAnimationWidget.inkDrop(
                                      color: const Color(0xff0FD481),
                                      size: 35,
                                    )
                                  : Text(
                                      "register".tr,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'haveaccount'.tr,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offNamed('/login');
                                  },
                                  child: Text(
                                    'login'.tr,
                                    style: const TextStyle(
                                        color: Color(0xff0DB770),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
          fontSize: 16.0,
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
        prefixIcon: Icon(
          icon,
          color: Colors.black,
          size: 20,
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
