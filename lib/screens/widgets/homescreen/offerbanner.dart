import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../views/local_vars.dart';

Container offerBanner(List offers) {
  return offers.isNotEmpty
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
                      "offers".tr,
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
                      Get.toNamed("/showoffers", arguments: offers);
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
                child: Container(
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        for (int i = 0;
                            i < (offers.length <= 8 ? offers.length : 8);
                            i++) ...[
                          offersButton(offers[i], false),
                          const SizedBox(width: 15),
                        ]
                      ],
                    )),
              ),
            ],
          ),
        )
      : Container();
}

Widget offersButton(dynamic offers, bool maxwidth) {
  return GestureDetector(
    onTap: () {
      if (offers.place == null && offers.url != null) {
        launchUrl(
          Uri.parse(offers.url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.toNamed("/showplace",
            arguments: [offers.place.name, offers.place, false]);
      }
    },
    child: SizedBox(
      width: maxwidth ? double.infinity : 300,
      height: maxwidth ? 200 : 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: "$imageSource${offers.image}",
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return const BlurHash(
                hash:
                    "QNJi9v71%OrZa3NHnTwdNa};-@RPIpV]WFNdocso}*[pNFaJM{^NSck8xF");
          },
        ),
      ),
    ),
  );
}
