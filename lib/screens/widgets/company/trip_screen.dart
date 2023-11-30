import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:guide/views/colors.dart';
import 'package:guide/views/local_vars.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  CarouselController carouselController = CarouselController();
  final name = Get.arguments[0];
  final data = Get.arguments[1];

  late int picCount;
  int picIndex = 0;

  @override
  void initState() {
    picCount = data.tripImages.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$name".tr,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w600,
            fontFamily: "redex",
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //images container
                      Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: CarouselSlider(
                              items: [
                                if (data.tripImages.length == 0) ...[
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xfff5f6f9),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      // margin: EdgeInsets.symmetric(horizontal: 1),
                                      child: Image.asset(
                                        "assest/images/arabiclogo.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  for (int i = 0;
                                      i < data.tripImages.length;
                                      i++) ...[
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        // margin: EdgeInsets.symmetric(horizontal: 1),
                                        child: CachedNetworkImage(
                                          imageUrl: data.tripImages[i].imageUrl,
                                          placeholder: (context, url) {
                                            return const BlurHash(
                                              hash:
                                                  "L5H2EC=PM+yV0g-mq.wG9c010J}I",
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ]
                                ]
                              ],
                              carouselController: carouselController,
                              options: CarouselOptions(
                                height: 300,
                                aspectRatio: 16 / 9,
                                viewportFraction:
                                    data.tripImages.length == 1 ? 0.9 : 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: false,
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    picIndex = index;
                                  });
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 8,
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < picCount; i++) ...[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Container(
                                          width: picIndex == i ? 12 : 8,
                                          height: picIndex == i ? 12 : 8,
                                          decoration: BoxDecoration(
                                              color: picIndex == i
                                                  ? const Color(0xff0FD481)
                                                  : Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: const Offset(0,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        ),
                                      )
                                    ]
                                  ],
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                data.tripName,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //description container
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "tripshortdetails".tr,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "redex",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: SelectableText(
                              data.shortDescription,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Details container
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "tripdetails".tr,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "redex",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: SelectableText(
                              data.tripDetails,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.grey.withOpacity(0.6),
              child: GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse("https://wa.me/$companyPhone"),
                      mode: LaunchMode.externalApplication);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                        size: 19,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text("support".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
