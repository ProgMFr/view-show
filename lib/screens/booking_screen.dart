import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../controllers/change_country.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CountryController countryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => countryController.countriesInfo.isNotEmpty
            ? countryController.countriesInfo[0] == "notfound" ||
                    countryController.countriesInfo[0] == "error"
                ? Center(child: notAvilable("notavilable", 250))
                : SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("bookingtitle".tr,
                                    style: const TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 18,
                                        fontFamily: "dubai",
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("bookingcontent".tr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: "dubai",
                                        fontWeight: FontWeight.w400)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("choosecitybooking".tr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "dubai",
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              image: DecorationImage(
                                image: BlurHashImage(
                                    "QEG}XX=W1HF3FqV|E*OTOE}HO9E#=2s*NdsDk8SN0}Ab\$\$\$L,bs+\$gjasA"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text("choscity".tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: ResponsiveGridRow(
                                        children: [
                                          // ResponsiveGridCol(
                                          //   xs: 12,
                                          //   child: Container(
                                          //     padding: EdgeInsets.symmetric(vertical: 10),
                                          //     child: adsBanner(context,),
                                          //   ),
                                          // ),
                                          for (int i = 0;
                                              i <
                                                  countryController
                                                      .countriesInfo[0]
                                                      .companiesWithCities
                                                      .length;
                                              i++) ...[
                                            countryB(countryController
                                                .countriesInfo[0]
                                                .companiesWithCities[i]
                                                .cityName),
                                          ],

                                          ResponsiveGridCol(
                                              child:
                                                  const SizedBox(height: 20)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xff0FD481),
                  size: 50,
                ),
              )));
  }

  ResponsiveGridCol countryB(String name) {
    return ResponsiveGridCol(
        xs: 4,
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/citycompany', arguments: name);
          },
          child: Container(
              margin: const EdgeInsets.all(8),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 13),
                  const Icon(
                    Iconsax.map,
                    color: Colors.deepOrange,
                    size: 35,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      name.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        height: 1,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
