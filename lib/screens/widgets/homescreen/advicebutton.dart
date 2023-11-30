import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/views/colors.dart';

Container adviceBanner(List recommededPlaces) {
  return recommededPlaces.isNotEmpty
      ? Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "recommed".tr,
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
                      Get.toNamed("/showadvices", arguments: recommededPlaces);
                    },
                    child: Text(
                      "showmore".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    for (int i = 0;
                        i <
                            (recommededPlaces.length <= 8
                                ? recommededPlaces.length
                                : 8);
                        i++) ...[
                      recommedB(recommededPlaces[i], false),
                      const SizedBox(
                        width: 15,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        )
      : Container();
}

Widget recommedB(var recommededPlace, bool maxwidth) {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/showplace", arguments: [
        recommededPlace.place.name,
        recommededPlace.place,
        false
      ]);
    },
    child: SizedBox(
      width: maxwidth ? double.infinity : 300,
      height: maxwidth ? 200 : 150,
      child: Stack(
        children: [
          if (recommededPlace.place.placeImages.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: maxwidth ? double.infinity : 300,
                height: maxwidth ? 200 : 150,
                child: CachedNetworkImage(
                  imageUrl: recommededPlace.place.placeImages[0].imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
                  },
                ),
              ),
            ),
          ] else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: SizedBox(
                    width: maxwidth ? double.infinity : 300,
                    height: maxwidth ? 200 : 150,
                    child: Image.asset(
                      "assest/images/arabiclogo.png",
                      fit: BoxFit.contain,
                    )),
              ),
            ),
          ],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: maxwidth ? 60 : 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.black.withOpacity(0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 18, left: 18),
                        child: Text(
                          recommededPlace.place.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: maxwidth ? 17 : 15,
                            height: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            FontAwesomeIcons.mapLocationDot,
                            color: secondaryColor,
                            size: maxwidth ? 17 : 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            recommededPlace.place.shortLocation,
                            maxLines: 1,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: maxwidth ? 14 : 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
