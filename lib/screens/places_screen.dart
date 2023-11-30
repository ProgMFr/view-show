import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/getplaces_controller.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late GetPlacesController getPlacesController;
  late ScrollController scrollController2;
  late ScrollController scrollController;
  var cityid = Get.arguments[0];
  var placetype = Get.arguments[1];
  var subTypes = Get.arguments[2];
  final List<GlobalKey> itemKeys = Get.arguments[2] != null
      ? List.generate(Get.arguments[2].length + 1, (index) => GlobalKey())
      : List.generate(1, (index) => GlobalKey());
  int inedxint = 0;
  String selectfilter = "all";
  int pagenum = 1;
  changeType(String type, int pagenumi, int index) {
    if (type != selectfilter) {
      // double offset = index * 100.0;
      getPlacesController.clearPlaces();
      Scrollable.ensureVisible(itemKeys[index].currentContext!,
          alignment: 0.5,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn);
      // scrollController2.animateTo(offset,
      //     duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      setState(() {
        selectfilter = type;
        pagenum = 1;
        inedxint = index;
      });
    }
    if (selectfilter == type) {
      getPlacesController.clearPlaces();
      if (type == "all") {
        getPlacesController.getPlaces(cityid, placetype, pagenumi);
      } else if (type == "high" || type == "low") {
        getPlacesController.getPlacesWithprice(cityid, 1, type);
      } else {
        getPlacesController.getPlacesWithType(
            cityid, placetype, pagenumi, type);
      }
    } else {
      if (type == "all") {
        getPlacesController.getPlaces(cityid, placetype, pagenumi);
      } else if (type == "high" || type == "low") {
        getPlacesController.getPlacesWithprice(cityid, 1, type);
      } else {
        getPlacesController.getPlacesWithType(
            cityid, placetype, pagenumi, type);
      }
    }
  }

  @override
  void initState() {
    getPlacesController = Get.put(GetPlacesController());
    scrollController = ScrollController();
    scrollController2 = ScrollController();
    getPlacesController.getPlaces(cityid, placetype, 1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          pagenum++;
        });
        if (selectfilter == "all") {
          Get.showOverlay(
            asyncFunction: () async {
              await getPlacesController.getPlaces(cityid, placetype, pagenum);
            },
            loadingWidget: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xff0FD481),
                size: 50,
              ),
            ),
            opacity: 0.1,
          );
        } else if (selectfilter == "high" || selectfilter == "low") {
          Get.showOverlay(
            asyncFunction: () async {
              await getPlacesController.getPlacesWithprice(
                  cityid, pagenum, selectfilter);
            },
            loadingWidget: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xff0FD481),
                size: 50,
              ),
            ),
            opacity: 0.1,
          );
        } else {
          Get.showOverlay(
            asyncFunction: () async {
              await getPlacesController.getPlacesWithType(
                  cityid, placetype, pagenum, selectfilter);
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
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    getPlacesController.clearPlaces();
    getPlacesController.dispose();
    scrollController.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$placetype".tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'redex')),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
        ),
        body: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              subTypes != null
                  ? Container(
                      height: 60,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.1),
                      child: Scrollbar(
                        controller: scrollController2,
                        child: SingleChildScrollView(
                          controller: scrollController2,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  changeType("all", 1, 0);
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    key: itemKeys[0],
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: selectfilter == "all"
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "all".tr,
                                      style: TextStyle(
                                        color: selectfilter == "all"
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              if (subTypes != null) ...{
                                for (int i = 0; i < subTypes.length; i++) ...[
                                  filterContainer(subTypes[i], i + 1)
                                ]
                              },
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Obx(
                () => getPlacesController.placesInfo.isEmpty
                    ? Expanded(
                        child: Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xff0FD481),
                            size: 50,
                          ),
                        ),
                      )
                    : getPlacesController.placesInfo[0] == "notfound" ||
                            getPlacesController.placesInfo[0] == "error"
                        ? Expanded(
                            child:
                                Center(child: notAvilable("notavilable", 250)))
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              controller: scrollController,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  for (int i = 0;
                                      i < getPlacesController.placesInfo.length;
                                      i++) ...[
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: placeContainer(
                                          getPlacesController.placesInfo[i],
                                          subTypes == null ? true : false),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
              )
            ],
          ),
        ));
  }

  GestureDetector filterContainer(item, int index) {
    return GestureDetector(
      onTap: () {
        changeType(item.toString(), 1, index);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          key: itemKeys[index],
          height: 30,
          decoration: BoxDecoration(
            color:
                selectfilter == item.toString() ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            item.toString().tr,
            style: TextStyle(
              color:
                  selectfilter == item.toString() ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
