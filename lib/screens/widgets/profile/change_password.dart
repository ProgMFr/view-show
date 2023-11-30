import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controllers/profile_controller.dart';
import '../../../views/colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ProfileController profileController = Get.find();
  bool loading = false;
  bool passwordvalid = false;
  bool password2valid = false;
  bool passwordorg = false;
  TextEditingController password2controller = TextEditingController();
  TextEditingController orginalpasscontroller = TextEditingController();
  TextEditingController password1controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("pchangepass".tr,
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
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.lock,
                    color: Color(0xff0FD481),
                    size: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  cTextFiled(
                      TextInputType.text,
                      "orginalpassword".tr,
                      "",
                      Iconsax.lock,
                      orginalpasscontroller,
                      passwordorg,
                      "orginalpasserr".tr),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  cTextFiled(
                      TextInputType.text,
                      "newpassword".tr,
                      "passwordhint".tr,
                      Iconsax.lock,
                      password1controller,
                      passwordvalid,
                      "passwordhint".tr),
                  const SizedBox(
                    height: 20,
                  ),
                  cTextFiled(
                      TextInputType.text,
                      "confirmpassword".tr,
                      "confpasswordhint".tr,
                      Iconsax.lock,
                      password2controller,
                      password2valid,
                      "passwordvalidation".tr),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (orginalpasscontroller.text.isEmpty) {
                        setState(() {
                          passwordorg = true;
                        });
                      } else {
                        setState(() {
                          passwordorg = false;
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

                      if (!passwordvalid && !password2valid && !passwordorg) {
                        Get.dialog(AlertDialog(
                          elevation: 0,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.lock,
                                color: secondaryColor,
                                size: 60,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "pchangepass".tr,
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
                                              color: secondaryColor,
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "no".tr,
                                          style: const TextStyle(
                                            color: secondaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
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
                                              profileController.changePass(
                                                  orginalpasscontroller.text,
                                                  password1controller.text))
                                          .then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                        if (value == "done") {
                                          setState(() {
                                            password1controller.text = "";
                                            password2controller.text = "";
                                            orginalpasscontroller.text = "";
                                          });

                                          Get.snackbar(
                                            "changepasssuccess".tr,
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
                                        } else {
                                          Get.snackbar("reviewerrortitle".tr,
                                              "orgpasserr".tr,
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.7),
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
                      }
                    },
                    height: 40,
                    minWidth: 200,
                    color: loading ? Colors.white : const Color(0xff0DB770),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: loading
                        ? LoadingAnimationWidget.inkDrop(
                            color: const Color(0xff0FD481),
                            size: 30,
                          )
                        : Text(
                            "pchangepass".tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                  ),
                ],
              ),
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(10.0),
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
