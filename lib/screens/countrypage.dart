import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  var citylist = Get.arguments[0];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff5f6f9),
      appBar: AppBar(
        title: Text("choosecountry".tr,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ResponsiveGridRow(
                children: [
                  // ResponsiveGridCol(
                  //   xs: 12,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 10),
                  //     child: adsBanner(context,),
                  //   ),
                  // ),
                  for (int i = 0; i < citylist.length; i++) ...[
                    countryB(citylist[i].cityName, citylist[i].id),
                  ],

                  ResponsiveGridCol(child: const SizedBox(height: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ResponsiveGridCol countryB(String name, String cityid) {
    return ResponsiveGridCol(
        xs: 4,
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/placecate', arguments: [name, cityid]);
          },
          child: Container(
              margin: const EdgeInsets.all(5),
              height: 120,
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
                    alignment: Alignment.center,
                    child: Text(
                      name.tr,
                      textAlign: TextAlign.center,
                      maxLines: 2,
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
        ));
  }
}
