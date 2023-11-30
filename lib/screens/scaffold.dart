import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:guide/controllers/change_country.dart';
import 'package:guide/main.dart';
import 'package:guide/screens/booking_screen.dart';
import 'package:guide/screens/home_screen.dart';
import 'package:guide/screens/profile_screen.dart';
import 'package:guide/screens/search_screen.dart';
import 'package:guide/screens/settings_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
part 'widgets/nav_bar.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int dropdownindexnum = 0;
  CountryController countryController = Get.find();
  Map<String, int> dropdownindex = {
    'IRAQ': 0,
    'TURKEY': 1,
    'IRAN': 3,
    'UNITED_ARAB_EMIRATES': 4,
    'SAUDI_ARABIA': 5,
    'LEBANON': 6,
    'SYRIA': 5,
    'OMAN': 7,
    'EGYPT': 8,
    'TUNISIA': 9,
    'AZERBAIJAN': 10,
    'ARMENIA': 11,
    'GEORGIA': 12,
    'INDONESIA': 13,
    'MALAYSIA': 14,
    'THAILAND': 15,
    "SRILANKA": 16,
  };
  List<CoolDropdownItem> dropdownList = [
    CoolDropdownItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/iq.svg",
        ),
      ),
      label: 'IRAQ'.tr,
      value: 'IRAQ',
    ),
    CoolDropdownItem(
      label: 'TURKEY'.tr,
      value: 'TURKEY',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/tr.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'IRAN'.tr,
      value: 'IRAN',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/ir.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'UNITED_ARAB_EMIRATES'.tr,
      value: 'UNITED_ARAB_EMIRATES',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/ae.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'SAUDI_ARABIA'.tr,
      value: 'SAUDI_ARABIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/sa.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'LEBANON'.tr,
      value: 'LEBANON',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/lb.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'SYRIA'.tr,
      value: 'SYRIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/sy.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'OMAN'.tr,
      value: 'OMAN',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/om.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'EGYPT'.tr,
      value: 'EGYPT',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/eg.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'TUNISIA'.tr,
      value: 'TUNISIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/tn.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'AZERBAIJAN'.tr,
      value: 'AZERBAIJAN',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/az.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'ARMENIA'.tr,
      value: 'ARMENIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/am.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'GEORGIA'.tr,
      value: 'GEORGIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/ge.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'INDONESIA'.tr,
      value: 'INDONESIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/id.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'MALAYSIA'.tr,
      value: 'MALAYSIA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/my.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'THAILAND'.tr,
      value: 'THAILAND',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/th.svg",
        ),
      ),
    ),
    CoolDropdownItem(
      label: 'SRILANKA'.tr,
      value: 'SRILANKA',
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          "assest/images/flags/lk.svg",
        ),
      ),
    ),
  ];
  DropdownController wcontroller = DropdownController();
  int currentIndex = 2;
  List<Widget> screens = [
    const ProfilePage(),
    const BookingPage(),
    const HomeScreen(),
    const SearchPage(),
    const SettingsPage(),
  ];
  void chancurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    dropdownindexnum = appdataprefs!.getInt("dropdown")!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(currentIndex, chancurrentIndex),
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: currentIndex == 0 ? null : appBar2(),
      body: Obx(
        () => countryController.countriesInfo.isEmpty
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xff0FD481),
                  size: 50,
                ),
              )
            : screens[currentIndex],
      ),
    );
  }

  AppBar appBar2() {
    return AppBar(
      centerTitle: false,
      flexibleSpace: Directionality(
        textDirection: appdataprefs!.getString('language') == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  appdataprefs!.getString('language') == 'en'
                      ? "assest/images/logo4.png"
                      : "assest/images/arabiclogo.png",
                  height: 40,
                ),
                CoolDropdown(
                  dropdownOptions: const DropdownOptions(
                    width: 130,
                    color: Colors.black,
                  ),
                  resultOptions: ResultOptions(
                    width: 130,
                    // height: 100,
                    space: 0,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    alignment: Alignment.center,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: SizedBox(
                          width: 12,
                          height: 12,
                          child: CustomPaint(
                              painter: DropdownArrowPainter(
                            color: Colors.black,
                          ))),
                    ),
                    boxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  dropdownList: dropdownList,
                  defaultItem: dropdownList[dropdownindexnum],
                  dropdownItemOptions: DropdownItemOptions(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(10),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    boxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selectedBoxDecoration: BoxDecoration(
                      color: const Color.fromARGB(255, 14, 11, 11),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: wcontroller,
                  onChange: (v) {
                    setState(() {
                      dropdownindexnum = dropdownindex[v]!;
                      appdataprefs!.setString('country', v);
                      appdataprefs!.setInt('dropdown', dropdownindex[v]!);
                      countryController.checkCountries();
                      wcontroller.close();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      // elevation: 0,
    );
  }
}
