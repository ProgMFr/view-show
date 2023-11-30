import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/merchant_images_controller.dart';
import 'package:guide/controllers/profile_controller.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/views/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AddImages extends StatefulWidget {
  const AddImages({super.key});

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  ProfileController profileController = Get.find();
  MerchantController merchantController = Get.find();
  late MerchantImagesController merchantImagesController;
  Future pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    var imageTemp = File(image.path);
    Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "addnewpic".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff0FD481),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 275,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                    image: FileImage(imageTemp),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: const Color(0xff0FD481), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "no".tr,
                          style: const TextStyle(
                            color: Color(0xff0FD481),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "redex",
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.showOverlay(
                        asyncFunction: () async {
                          await merchantImagesController.addImage(
                              imageTemp, merchantController.placeInfo[0].id);
                        },
                        loadingWidget: Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xff0FD481),
                            size: 50,
                          ),
                        ),
                        opacity: 0.1,
                      );
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xff0FD481),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "yes".tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "redex",
                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    merchantImagesController = Get.put(MerchantImagesController());
    merchantImagesController.getImages();

    super.initState();
  }

  @override
  void dispose() {
    merchantImagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        profileController.getProfile();
        merchantController.getPlace();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "editimage".tr,
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
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Obx(
                  () => merchantImagesController.merchantImages.isEmpty
                      ? Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xff0FD481),
                            size: 50,
                          ),
                        )
                      : merchantImagesController.merchantImages[0] ==
                                  "noimages" ||
                              merchantImagesController.merchantImages[0] ==
                                  "error"
                          ? Center(child: notAvilable("", 250))
                          : SingleChildScrollView(
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
                                        for (int i = 0;
                                            i <
                                                merchantImagesController
                                                    .merchantImages.length;
                                            i++) ...[
                                          ResponsiveGridCol(
                                              xs: 6,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8),
                                                      height: 150,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 2,
                                                            blurRadius: 2,
                                                            offset: const Offset(
                                                                0,
                                                                1), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              merchantImagesController
                                                                  .merchantImages[
                                                                      i]
                                                                  .imageUrl,
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (context, url) {
                                                            return Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Center(
                                                                child:
                                                                    LoadingAnimationWidget
                                                                        .inkDrop(
                                                                  color: const Color(
                                                                      0xff0FD481),
                                                                  size: 50,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                                  Positioned(
                                                    bottom: 15,
                                                    right: 15,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.showOverlay(
                                                          asyncFunction:
                                                              () async {
                                                            await merchantImagesController
                                                                .deleteImage(
                                                                    merchantImagesController
                                                                        .merchantImages[
                                                                            i]
                                                                        .id);
                                                          },
                                                          loadingWidget: Center(
                                                            child:
                                                                LoadingAnimationWidget
                                                                    .inkDrop(
                                                              color: const Color(
                                                                  0xff0FD481),
                                                              size: 50,
                                                            ),
                                                          ),
                                                          opacity: 0.1,
                                                        );
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              spreadRadius: 3,
                                                              blurRadius: 3,
                                                              offset: const Offset(
                                                                  1,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .trash,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                        ResponsiveGridCol(
                                            child: const SizedBox(height: 10)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
                Positioned(
                  bottom: 40,
                  left: 24,
                  right: 24,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: secondaryColor.withOpacity(0.3),
                          offset: const Offset(1, 1),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: MaterialButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.image,
                              color: Colors.white,
                              size: 25,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "addnewpic".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
