import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../views/local_vars.dart';

Widget adsBanner(
    BuildContext context, List advertisements, String? supportPhone) {
  List<Widget> ads = advertisements.isEmpty
      ? [
          addAds(
              context, '', "wantads", "adscontact", supportPhone, "null", true),
        ]
      : [
          for (int i = 0; i < advertisements.length; i++) ...[
            adsbutton(
                context,
                advertisements[i].image,
                // '',
                advertisements[i].title,
                advertisements[i].shortDescription,
                advertisements[i].url,
                advertisements[i].place,
                false)
          ],
          addAds(
              context, '', "wantads", "adscontact", supportPhone, "null", true),
        ];
  return CarouselSlider(
    options: CarouselOptions(
      pauseAutoPlayOnTouch: true,
      autoPlay: advertisements.isEmpty ? false : true,
      enableInfiniteScroll: advertisements.isEmpty ? false : true,
      animateToClosest: true,
      // aspectRatio: 5.0,
      autoPlayCurve: Curves.easeInOutQuad,
      height: 134,

      viewportFraction: 1,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(seconds: 2),
    ),
    items: [...ads],
  );
}

Widget adsbutton(BuildContext context, String? image, String title, String info,
    String? url, dynamic place, bool addAds) {
  return SizedBox(
    // margin: const EdgeInsets.only(left: 15),
    //mediaQuery.size.width * 0.8
    width: MediaQuery.of(context).size.width * 0.95,
    // height: ,
    child: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assest/images/merchainad.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),

                      padding: image == null || image == ''
                          ? const EdgeInsets.all(8)
                          : EdgeInsets.zero,
                      // margin: const EdgeInsets.all(10),

                      width:
                          (MediaQuery.of(context).size.width * 0.95 - 10) / 2,
                      height: 110,

                      child: image == null || image == ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assest/images/arabiclogo.png',
                                fit: BoxFit.contain,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: '$imageSource$image',
                                placeholder: (context, url) {
                                  return const BlurHash(
                                      hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                      // alignment: Alignment.center,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // textAlign: TextAlign.right,
                              title,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              // textAlign: TextAlign.left,
                              info,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: appdataprefs!.getString("language") == 'ar' ? 15 : null,
          right: appdataprefs!.getString("language") == 'ar' ? null : 15,
          bottom: 12,
          child: GestureDetector(
            onTap: () {
              // url luncher
              if (place == null && url != null) {
                launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              } else {
                Get.toNamed("/showplace",
                    arguments: [place.name, place, false]);
              }
            },
            child: Text(
              "showads".tr,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget adsbutton2(BuildContext context, String? image, String title,
//     String info, String? url, dynamic place, bool addAds) {
//   return GestureDetector(
//     onTap: () {
//       // url luncher
//       if (place == null && url != null) {
//         launchUrl(
//           Uri.parse(url),
//           mode: LaunchMode.externalApplication,
//         );
//       } else {
//         Get.toNamed("/showplace", arguments: [place.name, place, false]);
//       }
//     },
//     child: Container(
//       width: MediaQuery.of(context).size.width * 0.95,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: CachedNetworkImage(
//           imageUrl: '$imageSource$image',
//           placeholder: (context, url) {
//             return const BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I");
//           },
//           fit: BoxFit.contain,
//         ),
//       ),
//     ),
//   );
// }

Widget addAds(BuildContext context, String? image, String title, String info,
    String? url, dynamic place, bool addAds) {
  return SizedBox(
    // margin: const EdgeInsets.only(left: 15),
    //mediaQuery.size.width * 0.8
    width: MediaQuery.of(context).size.width * 0.95,
    // height: ,
    child: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assest/images/addadsbanner3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              // padding: EdgeInsets.zero,
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    title.tr,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    info.tr,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.fade,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      // url luncher
                      var text =
                          '''السلام عليكم ارغب بالاعلان داخل التطبيق وهذه معلومات حسابي:
الاسم : *${appdataprefs!.getString("fname")} ${appdataprefs!.getString("lname")}*
الايميل : ```${appdataprefs!.getString("email")}```
رقم الهاتف : ```${appdataprefs!.getString("phone")}```
*ارسل الرسالة كما هي بدون تعديل*'''; //+92xx enter like this
                      var whatsappURLIos =
                          "https://wa.me/+$paymentPhone?text=${Uri.tryParse(text)}";
                      // await launchUrl(Uri.parse(whatsappURlAndroid));
                      var whatsappURlAndroid =
                          "https://wa.me/+$paymentPhone?text=$text";

                      if (Platform.isAndroid) {
                        launchUrl(Uri.parse(whatsappURlAndroid),
                            mode: LaunchMode.externalApplication);
                      } else {
                        launchUrl(Uri.parse(whatsappURLIos),
                            mode: LaunchMode.externalApplication);
                      }
                      // if (Platform.isIOS) {
                      //   // for iOS phone only
                      //   if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
                      //     await launchUrl(Uri.parse(
                      //       whatsappURLIos,
                      //     ));
                      //   } else {
                      //     Get.snackbar("Whatsapp not installed",
                      //         "Whatsapp not installed");
                      //   }
                      // } else {
                      //   print("whatsappURLIos");
                      //   // android , web
                      //   if (await canLaunchUrl(
                      //       Uri.parse(whatsappURlAndroid))) {
                      //     await launchUrl(
                      //       Uri.parse(whatsappURlAndroid),
                      //     );
                      //   } else {
                      //     Get.snackbar("Whatsapp not installed",
                      //         "Whatsapp not installed");
                      //   }
                      // }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      width: 180,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "adscontactb".tr,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
