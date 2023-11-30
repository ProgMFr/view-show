import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/change_country.dart';
import 'package:guide/controllers/search_controller.dart';
import 'package:guide/main.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CountryController countryController = Get.find();
  late MySearchController searchController;
  TextEditingController searchtextc = TextEditingController();
  late ScrollController scrollController;
  String cityname = "* ${"allcitiescheck".tr}";
  String placetype = "* ${"allcatecheck".tr}";

  bool loading = false;
  bool empty = false;
  bool showclear = false;
  int pagenum = 1;
  @override
  void initState() {
    searchController = Get.put(MySearchController());
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          pagenum++;
        });
        Get.showOverlay(
          asyncFunction: () async {
            await searchController.completeSearch(searchtextc.text, pagenum);
          },
          loadingWidget: Center(
            child: LoadingAnimationWidget.inkDrop(
              color: const Color(0xff0FD481),
              size: 50,
            ),
          ),
          opacity: 0.1,
        );
      }
    });
    super.initState();
  }

  changeTypes() {
    setState(() {
      cityname = appdataprefs!.getInt("searchcity") == 300
          ? "* ${"allcitiescheck".tr}"
          : "* ${countryController.countriesInfo[0].cities[appdataprefs!.getInt("searchcity")!].cityName}";
      placetype = appdataprefs!.getInt("searchtype") == 0
          ? "* ${"allcatecheck".tr}"
          : "* ${appdataprefs!.getString("searchtypestring")!.tr}";
    });
  }

  @override
  void dispose() {
    searchController.searchInfo.clear();
    searchtextc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => countryController.countriesInfo.isNotEmpty
            ? countryController.countriesInfo[0] == "notfound" ||
                    countryController.countriesInfo[0] == "error"
                ? Center(child: notAvilable("notavilable", 250))
                : Column(
                    children: [
                      // Text(appdataprefs!.getString("countryid")!),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.black,
                                      controller: searchtextc,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            showclear = true;
                                          });
                                        } else {
                                          setState(() {
                                            showclear = false;
                                          });
                                        }
                                      },
                                      onSubmitted: (value) {
                                        if (value.length > 2) {
                                          setState(() {
                                            loading = true;
                                            empty = false;
                                            pagenum = 1;
                                          });

                                          searchController
                                              .searchResult(searchtextc.text);
                                        } else {
                                          Get.snackbar("reviewerrortitle".tr,
                                              "searchrequired".tr,
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.7),
                                              icon: const Icon(
                                                FontAwesomeIcons
                                                    .circleExclamation,
                                                color: Colors.red,
                                              ));
                                          setState(() {
                                            empty = true;
                                          });
                                        }
                                      },

                                      // onTapOutside: (event) {
                                      //   setState(() {
                                      //     loading = false;
                                      //   });
                                      // },

                                      // controller: passwordcontroller,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                        suffixIcon: showclear
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    searchtextc.clear();
                                                    loading = false;
                                                    empty = true;
                                                    showclear = false;
                                                    pagenum = 1;
                                                    searchController.searchInfo
                                                        .clear();
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : null,
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.magnifyingGlass,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        hintText: "search".tr,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        floatingLabelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        var parameters = <String, List>{
                                          "data": countryController
                                              .countriesInfo[0].cities,
                                        };
                                        Get.toNamed("/filter",
                                                arguments: parameters)
                                            ?.then((_) => setState(() {
                                                  changeTypes();
                                                }));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xff0FD481)),
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 45,
                                        child: const Icon(
                                          FontAwesomeIcons.sliders,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      cityname,
                                      style: const TextStyle(
                                        color: Color(0xff0FD481),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      placetype,
                                      style: const TextStyle(
                                        color: Color(0xff0FD481),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      empty
                          ? Container()
                          : (loading && searchController.searchInfo.isEmpty
                              ? SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: const Color(0xff0FD481),
                                      size: 50,
                                    ),
                                  ),
                                )
                              : (searchController.searchInfo.isNotEmpty
                                  ? (searchController.searchInfo[0] ==
                                              "notfound" ||
                                          searchController.searchInfo[0] ==
                                              "error"
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Text("notfound".tr,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'redex')),
                                        )
                                      : Expanded(
                                          child: ListView.builder(
                                              itemCount: searchController
                                                  .searchInfo.length,
                                              shrinkWrap: true,
                                              controller: scrollController,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15,
                                                    vertical: 2,
                                                  ),
                                                  child: placeContainer(
                                                    searchController
                                                        .searchInfo[index],
                                                    true,
                                                  ),
                                                );
                                              }),
                                        ))
                                  : Container())),
                    ],
                  )
            : Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xff0FD481),
                  size: 50,
                ),
              ),
      ),
    );
  }
}
