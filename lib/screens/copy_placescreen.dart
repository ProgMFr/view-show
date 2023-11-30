import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';

class PlaceCatePage extends StatefulWidget {
  const PlaceCatePage({super.key});

  @override
  State<PlaceCatePage> createState() => _PlaceCatePageState();
}

class _PlaceCatePageState extends State<PlaceCatePage> {
  var ags = Get.arguments[0];
  var cityid = Get.arguments[1];
  List<String> images = [
    "assest/images/placecate/holyplace.png",
    "assest/images/placecate/tourist.png",
    "assest/images/placecate/stay.png",
    "assest/images/placecate/mall.png",
    "assest/images/placecate/gym.png",
    "assest/images/placecate/salon.png",
    "assest/images/placecate/restaurant.png",
    "assest/images/placecate/host.png",
    "assest/images/placecate/cafe.png",
    "assest/images/placecate/park.png",
    "assest/images/placecate/gas.png",
    "assest/images/placecate/finan.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(ags,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
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

                  cateItem(
                      'tour', images[1], Colors.blue, 'touristplace', cityid),
                  cateItem(
                      'stay', images[2], Colors.green, 'stayplace', cityid),
                  cateItem('holy', images[0], Colors.blueAccent, 'holyplace',
                      cityid),
                  cateItem(
                      'mall', images[3], Colors.orangeAccent, 'mall', cityid),
                  cateItem(
                      'host', images[7], Colors.teal, 'healthcentre', cityid),

                  cateItem('rest', images[6], Colors.deepOrange, 'restaurant',
                      cityid),

                  cateItem('park', images[9], Colors.blueGrey, 'entertainment',
                      cityid),
                  cateItem(
                      'gass', images[10], Colors.red, 'gasstation', cityid),
                  cateItem('cafe', images[8], Colors.brown, 'cafe', cityid),
                  cateItem('gym', images[4], Colors.purple, 'gym', cityid),
                  cateItem('salon', images[5], Colors.orange, 'salons', cityid),

                  cateItem(
                      'finan', images[11], Colors.teal, 'financial', cityid),
                  ResponsiveGridCol(child: const SizedBox(height: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ResponsiveGridCol cateItem(
      String name, String image, Color color, String type, String cityid) {
    return ResponsiveGridCol(
      xs: 4,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/places', arguments: [name, cityid, type]);
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 150,
          child: Stack(
            children: [
              Container(
                // alignment: Alignment.center,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),

                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                  ),
                  // border: Border.all(
                  //   color: Colors.black,
                  //   width: 1,
                  // ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: 13),
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black87,
                                    blurRadius: 10.0,
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ]),
                            child: Image.asset(
                              image,
                              height: 70,
                              width: 70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              name.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
