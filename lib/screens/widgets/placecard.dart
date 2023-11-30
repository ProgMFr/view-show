import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../views/colors.dart';

Map<String, String> images = {
  "holyplace": "assest/images/placecate/holyplace.png",
  "touristplace": "assest/images/placecate/tourist.png",
  "stayplace": "assest/images/placecate/stay.png",
  "mall": "assest/images/placecate/mall.png",
  "sport": "assest/images/placecate/sport.png",
  "salons": "assest/images/placecate/salon.png",
  "restaurant": "assest/images/placecate/restaurant.png",
  "healthcenter": "assest/images/placecate/host.png",
  "cafe": "assest/images/placecate/cafe.png",
  "entertainment": "assest/images/placecate/park.png",
  "gasstation": "assest/images/placecate/gas.png",
  "financial": "assest/images/placecate/finan.png",
  "user": "assest/images/user.png"
};
GestureDetector latestContainer(var item) {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/showplace",
          arguments: [item.place.name, item.place, false]);
    },
    child: Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          item.place.placeImages.isEmpty
              ? Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage("assest/icon/icon.png"),
                      fit: BoxFit.contain,
                      opacity: 0.5,
                    ),
                  ),
                )
              : Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          item.place.placeImages[0].imageUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
          Expanded(
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(item.place.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),
                        const Spacer(),
                        if (item.place.type.toString().toLowerCase() !=
                            "placemixin") ...{
                          Image.asset(
                            images[item.place.type.toString().toLowerCase()]!,
                            width: 15,
                            height: 15,
                          ),
                          const SizedBox(width: 5),
                        },
                        Text(item.place.type.toString().toLowerCase().tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // color: Colors.red,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(item.place.description,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            height: 1.2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.locationDot,
                        size: 12,
                        color: Colors.indigo,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(item.place.shortLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

GestureDetector placeContainer(var item, bool emptySubType,
    {bool fromprofile = false}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/showplace", arguments: [item.name, item, fromprofile]);
    },
    child: Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          item.placeImages.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        Image.asset("assest/icon/icon.png", fit: BoxFit.cover),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        imageUrl: item.placeImages[0].imageUrl,
                        placeholder: (context, url) {
                          return const BlurHash(
                              hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
                        },
                        fit: BoxFit.cover),
                  ),
                ),
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            child: Text(item.name,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        Image.asset(
                          images[item.type.toString().toLowerCase()]!,
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                            emptySubType
                                ? item.type.toString().toLowerCase().tr
                                : item.subtype.toString().toLowerCase().tr,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // color: Colors.red,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(item.description,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            height: 1.2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.locationDot,
                        size: 12,
                        color: Colors.indigo,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(item.shortLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      if (item.price != null &&
                          item.type.toString().toLowerCase() ==
                              "stayplace") ...{
                        Row(
                          children: [
                            Text(
                              "${item.price}",
                              style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "IQD",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      },
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

GestureDetector companyContainer(var item) {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/companypage", arguments: [item, item.id]);
    },
    child: Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          item.image == null
              ? Container(
                  padding: const EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assest/icon/icon.png",
                        fit: BoxFit.cover,
                      )),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        imageUrl: item.image,
                        placeholder: (context, url) {
                          return const BlurHash(
                              hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
                        },
                        fit: BoxFit.cover),
                  ),
                ),
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(item.companyName,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(item.companyDescription,
                        maxLines: 4,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          height: 1.2,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                        )),
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

GestureDetector tripContainer(var item) {
  return GestureDetector(
    onTap: () {
      Get.toNamed("/tripscreen", arguments: [item.tripName, item]);
    },
    child: Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(
                  item.tripName,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: const TextStyle(
                    color: secondaryColor,
                    fontSize: 15,
                    height: 1.2,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 30,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.suitcase,
                    color: Colors.white,
                    size: 13,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    // item.tripName,
                    "bookanddetails".tr,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "redex",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
        ],
      ),
    ),
  );
}
