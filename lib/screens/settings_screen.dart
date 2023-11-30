import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/locale/locale_controller.dart';
import 'package:guide/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/local_vars.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LocaleController changeLocale = Get.find();

  @override
  void initState() {
    super.initState();
  }

  void changeLangage(String value, String langname) {
    setState(() {
      changeLocale.changeLocale(Locale(value), langname);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        FontAwesomeIcons.globe,
                        color: Colors.blueGrey,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "language".tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          alignment: Alignment.center,
                          items: [
                            DropdownMenuItem(
                              value: "ar",
                              child: Row(
                                children: [
                                  const Text(
                                    "العربية",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: SvgPicture.asset(
                                      "assest/images/flags/iq.svg",
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "en",
                              child: Row(
                                children: [
                                  const Text(
                                    "English",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: SvgPicture.asset(
                                      "assest/images/flags/us.svg",
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          value: appdataprefs!.getString("language"),
                          onChanged: (value) {
                            changeLangage(value.toString(), value.toString());
                          },
                        ),
                      )
                    ],
                  ),
                ),
                appdataprefs!.getString("country") == "IRAQ"
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed("/emergency");
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                FontAwesomeIcons.phoneVolume,
                                color: Colors.blue,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "emer".tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/terms");
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          FontAwesomeIcons.fileContract,
                          color: Colors.blueGrey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "terms".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/about");
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          FontAwesomeIcons.circleInfo,
                          color: Colors.blueGrey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "about".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.05),
                        Colors.blue.withOpacity(0.05),
                        const Color(0xFFEE1D52).withOpacity(0.05),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse("https://wa.me/$supportPhone"),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.teal,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "contactus".tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse("tel:+$supportPhone"),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                FontAwesomeIcons.phoneFlip,
                                color: Colors.indigo,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "callus".tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse("https://www.tiktok.com/@view_.iq"),
                                  mode: LaunchMode.externalApplication);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.tiktok,
                              color: Color(0xFFEE1D52),
                              size: 22,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse(
                                      "https://www.facebook.com/profile.php?id=61550583267414"),
                                  mode: LaunchMode.externalApplication);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse(
                                    "https://instagram.com/view_iq",
                                  ),
                                  mode: LaunchMode.externalApplication);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: GestureDetector(
                    onTap: () async {
                      await launchUrl(Uri.parse("https://t.me/MFProjects"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.code,
                            size: 14,
                            color: Colors.blueGrey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Developed & Designed By",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.withOpacity(0.5),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            child: const Text(
                              "Muhamed Farqad",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const FaIcon(
                            FontAwesomeIcons.telegram,
                            size: 13,
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
