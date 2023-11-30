import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_grid/responsive_grid.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var cityData = Get.arguments['data'];
  int selectTypeIndex = appdataprefs!.getInt("searchtype") ?? 0;
  int selectCityIndex = appdataprefs!.getInt("searchcity") ?? 300;
  changeIndex(int index, String type) {
    setState(() {
      selectTypeIndex = index;
      appdataprefs!.setInt("searchtype", index);
      appdataprefs!.setString("searchtypestring", type);
    });
  }

  changeCityIndex(int index, String type) {
    setState(() {
      selectCityIndex = index;
      appdataprefs!.setInt("searchcity", index);
      appdataprefs!.setString("searchcitystring", type);
    });
  }

  List<String> images = [
    "assest/images/placecate/holyplace.png",
    "assest/images/placecate/tourist.png",
    "assest/images/placecate/stay.png",
    "assest/images/placecate/mall.png",
    "assest/images/placecate/sport.png",
    "assest/images/placecate/salon.png",
    "assest/images/placecate/restaurant.png",
    "assest/images/placecate/host.png",
    "assest/images/placecate/cafe.png",
    "assest/images/placecate/park.png",
    "assest/images/placecate/gas.png",
    "assest/images/placecate/finan.png",
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("filter".tr,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'redex')),
        backgroundColor: Colors.white,
        elevation: 0,
        // toolbarHeight: 60,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // type of places
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ResponsiveGridRow(
                children: [
                  // ResponsiveGridCol(
                  //   xs: 12,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 10),
                  //     child: adsBanner(context,),
                  //   ),
                  // ),
                  ResponsiveGridCol(
                    xs: 12,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            height: 40,
                            child: Text(
                              "choosecate".tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              changeIndex(0, 'all');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectTypeIndex == 0
                                    ? Colors.black87
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 1.0,
                                    offset: const Offset(1.0, 1.0),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 40,
                              width: 150,
                              child: Text(
                                "allcatecheck".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectTypeIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  cateItem('touristplace', images[1], Colors.blue,
                      'touristplace', 1, selectTypeIndex, changeIndex, false),
                  cateItem('stayplace', images[2], Colors.green, 'stayplace', 2,
                      selectTypeIndex, changeIndex, false),
                  cateItem('holyplace', images[0], Colors.blueAccent,
                      'holyplace', 3, selectTypeIndex, changeIndex, false),
                  cateItem('mall', images[3], Colors.orangeAccent, 'mall', 4,
                      selectTypeIndex, changeIndex, false),
                  cateItem('healthcenter', images[7], Colors.teal,
                      'healthcenter', 5, selectTypeIndex, changeIndex, false),

                  cateItem('restaurant', images[6], Colors.deepOrange,
                      'restaurant', 6, selectTypeIndex, changeIndex, false),

                  cateItem('entertainment', images[9], Colors.blueGrey,
                      'entertainment', 7, selectTypeIndex, changeIndex, false),
                  cateItem('gasstation', images[10], Colors.red, 'gasstation',
                      8, selectTypeIndex, changeIndex, false),
                  cateItem('cafe', images[8], Colors.brown, 'cafe', 9,
                      selectTypeIndex, changeIndex, false),
                  cateItem('sport', images[4], Colors.purple, 'sport', 10,
                      selectTypeIndex, changeIndex, false),
                  cateItem('salons', images[5], Colors.orange, 'salons', 11,
                      selectTypeIndex, changeIndex, false),

                  cateItem('financial', images[11], Colors.teal, 'financial',
                      12, selectTypeIndex, changeIndex, false),
                ],
              ),
            ),
            // country chosen
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ResponsiveGridRow(
                children: [
                  // ResponsiveGridCol(
                  //   xs: 12,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 10),
                  //     child: adsBanner(context,),
                  //   ),
                  // ),
                  ResponsiveGridCol(
                    xs: 12,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            height: 40,
                            child: Text(
                              "choosecity".tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              changeCityIndex(300, 'all');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectCityIndex == 300
                                    ? Colors.black87
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 1.0,
                                    offset: const Offset(1.0, 1.0),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 40,
                              width: 150,
                              child: Text(
                                "allcitiescheck".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectCityIndex == 300
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  for (int i = 0; i < cityData.length; i++) ...[
                    cateItem(
                        cityData[i].cityName,
                        '',
                        Colors.blue,
                        cityData[i].id,
                        i,
                        selectCityIndex,
                        changeCityIndex,
                        true),
                  ]
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

ResponsiveGridCol cateItem(String name, String image, Color color, String type,
    int index, int selectindex, Function change, bool iscity) {
  return ResponsiveGridCol(
    xs: 3,
    child: GestureDetector(
      onTap: () {
        change(index, type);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 80,
        child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: selectindex == index ? Colors.black87 : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 1.0,
                  offset: const Offset(1.0, 1.0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 13),
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: iscity
                      ? FaIcon(Iconsax.location,
                          color: selectindex == index
                              ? Colors.white
                              : const Color(0xff0FD481),
                          size: 30)
                      : Image.asset(
                          image,
                          height: 38,
                          width: 38,
                        ),
                ),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    name.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectindex == index ? Colors.white : Colors.black,
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ),
    ),
  );
}
