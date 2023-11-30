import 'dart:async';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/signin_controller.dart';
import 'package:guide/locale/locale_controller.dart';
import 'package:guide/main.dart';
// import 'package:guide/views/text-styled.dart';

import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LocaleController localeController = Get.find();
  List<CoolDropdownItem> dropdownList = [
    CoolDropdownItem(
      icon: SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
            'assest/images/us.png',
            fit: BoxFit.cover,
          )),
      label: '',
      value: 'en',
    ),
    CoolDropdownItem(
      label: '',
      value: 'ar',
      icon: SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
            'assest/images/iq.png',
            fit: BoxFit.cover,
          )),
    ),
  ];
  DropdownController wcontroller = DropdownController();
  bool showPassword = false;
  bool loading = false;
  late Timer timer;
  LoginController controller = Get.put(LoginController());
  late int phonenumber;
  late String password;
  bool phoneval = false;
  bool passval = false;
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  int activeIndex = 0;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future login() async {
    if (phonecontroller.text.startsWith("0")) {
      phonenumber = int.parse(phonecontroller.text.replaceFirst("0", ""));
    } else {
      phonenumber = int.parse(phonecontroller.text);
    }
    password = passwordcontroller.text;

    return await controller.loginbutton(phonenumber, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              // color: Colors.red,
              padding: const EdgeInsets.all(10),
              height: 300,
              child: Stack(children: [
                loginShowImage(activeIndex, 0, "assest/rive/login1.jpg"),
                loginShowImage(activeIndex, 1, "assest/rive/login2.jpg"),
                loginShowImage(activeIndex, 2, "assest/rive/login3.jpg"),
                loginShowImage(activeIndex, 3, "assest/rive/login4.jpg"),
              ]),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  // color: Colors.black,
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: appdataprefs!.getString("language") == "en"
                            ? 160
                            : 85,
                        height: appdataprefs!.getString("language") == "en"
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
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: appdataprefs!.getString("language") == "en"
                                ? 15
                                : 5),
                        // color: Colors.greenAccent,
                        alignment: Alignment.center,
                        height: 90,
                        width: appdataprefs!.getString("language") == "en"
                            ? 150
                            : 170,
                        child: Center(
                          child: Text(
                            'logintitle'.tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Color(0xff0DB770),
                                fontSize: 21.0,
                                height: 1.3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black,
                        controller: phonecontroller,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'phonenum'.tr,
                          hintText: '',
                          errorText: phoneval ? "phonevalidation".tr : null,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          prefixIcon: const Icon(
                            Iconsax.call,
                            color: Colors.black,
                            size: 18,
                          ),
                          alignLabelWithHint: true,
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: showPassword ? false : true,
                        cursorColor: Colors.black,
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'password'.tr,
                          hintText: '',
                          errorText: passval ? "passwordhint".tr : null,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: FaIcon(
                              showPassword ? Iconsax.eye_slash : Iconsax.eye,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Iconsax.lock,
                            color: Colors.black,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignLabelWithHint: true,
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'forgetpassword'.tr,
                              style: TextStyle(
                                  color:
                                      const Color(0xff0DB770).withOpacity(0.9),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (phonecontroller.text.isNotEmpty &&
                              phonecontroller.text.isPhoneNumber &&
                              phonecontroller.text.isNumericOnly) {
                            setState(() {
                              phoneval = false;
                            });
                          } else {
                            setState(() {
                              phoneval = true;
                            });
                          }
                          if (passwordcontroller.text.isNotEmpty &&
                              passwordcontroller.text.length >= 8) {
                            setState(() {
                              passval = false;
                            });
                          } else {
                            setState(() {
                              passval = true;
                            });
                          }
                          if (!phoneval && !passval) {
                            setState(() {
                              loading = true;
                            });
                            Future.sync(() => login()).then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value == "done") {
                                Get.snackbar(
                                  "loginsuccess".tr,
                                  '',
                                  backgroundColor:
                                      Colors.black.withOpacity(0.7),
                                  colorText: Colors.white,
                                  icon: const Icon(
                                    FontAwesomeIcons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  backgroundGradient:
                                      const LinearGradient(colors: [
                                    Colors.teal,
                                    Colors.green,
                                  ]),
                                );
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    Get.offNamedUntil(
                                        '/home', (route) => false);
                                  });
                                });
                              } else if (value == "notfound") {
                                Get.snackbar(
                                    "reviewerrortitle".tr, "usernotexist".tr,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.7),
                                    icon: const Icon(
                                      FontAwesomeIcons.circleExclamation,
                                      color: Colors.red,
                                    ));
                              } else {
                                Get.snackbar("reviewerrortitle".tr, "error".tr,
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
                        color: loading ? Colors.white : const Color(0xff0DB770),
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
                                "login".tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'donothaveaccount'.tr,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offNamedUntil('/register', (route) => false);
                            },
                            child: Text(
                              'signup'.tr,
                              style: const TextStyle(
                                  color: Color(0xff0DB770),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Align loginShowImage(int activeIndex, int index, String imageUrl) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedOpacity(
        opacity: activeIndex == index ? 1 : 0,
        duration: const Duration(
          milliseconds: 1000,
        ),
        curve: Curves.linear,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
