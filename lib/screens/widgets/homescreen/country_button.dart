import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// this is the country button widget
// this widget is used in home screen
// this widget is used to show the country button
Widget countryContainer(List cities) {
  return cities.isNotEmpty
      ? Container(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          // color: const Color(0xff520B45).withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "cities".tr,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      var parameters = <int, List>{
                        0: cities,
                      };
                      Get.toNamed("/country", arguments: parameters);
                    },
                    child: Text(
                      "showmore".tr,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
                color: const Color(0xfff5f6f9),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (int i = 0;
                          i < (cities.length <= 6 ? cities.length : 6);
                          i++) ...[
                        countryB(cities[i].cityName, cities[i].id),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      : Container();
}

GestureDetector countryB(String name, String cityid) {
  return GestureDetector(
    onTap: () {
      Get.toNamed('/placecate', arguments: [name, cityid]);
    },
    child: Container(
        margin: const EdgeInsets.only(left: 12),
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 13),
            const Icon(
              Iconsax.map,
              color: Color(0xff0DB770),
              size: 40,
            ),
            const SizedBox(height: 8),
            Container(
              width: 105,
              alignment: Alignment.center,
              child: Text(
                name.tr,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff0DB770),
                  fontSize: 18,
                  height: 1,
                  overflow: TextOverflow.fade,
                  fontWeight: FontWeight.bold,
                  // shadows: [
                  //   Shadow(
                  //     blurRadius: 10.0,
                  //     color: Colors.black,
                  //     offset: Offset(1.0, 1.0),
                  //   ),
                  // ],
                ),
              ),
            ),
          ],
        )),
  );
}
