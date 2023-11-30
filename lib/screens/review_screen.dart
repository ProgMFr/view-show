import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/review_controller.dart';
import 'package:guide/main.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../views/colors.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late GetReviewsController getReviewsController;
  TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String placeId = Get.arguments[0];
  String type = Get.arguments[1];
  // bool error = true;
  int starCount = 1;
  @override
  void initState() {
    getReviewsController = Get.put(GetReviewsController());
    getReviewsController.getReview(placeId, type);
    super.initState();
  }

  void removeReview(String reviewId) async {
    var result = await getReviewsController.removeReview(reviewId, placeId);
    getReviewsController.getReview(placeId, type);
    if (result == "done") {
      Get.snackbar(
        "deletrevsuccess".tr,
        '',
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          FontAwesomeIcons.trash,
          color: Colors.white,
        ),
      );
    } else {
      Get.snackbar(
        "deletereverror".tr,
        '',
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          FontAwesomeIcons.circleExclamation,
          color: Colors.white,
        ),
      );
    }
  }

  void createReview(String comment, int rate) async {
    getReviewsController.clearReview();
    var result = await getReviewsController.createReview(
        placeId, comment.toString(), rate, type);
    getReviewsController.getReview(placeId, type);
    if (result == "done") {
      Get.snackbar(
        "reviewresult".tr,
        '',
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
        ),
        backgroundGradient: const LinearGradient(colors: [
          Colors.deepPurple,
          Colors.deepOrange,
        ]),
      );
    } else {
      Get.snackbar(
        "reviewresulterror".tr,
        '',
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          FontAwesomeIcons.circleExclamation,
          color: Colors.white,
        ),
      );
    }
  }

  void report(String reviewId) async {
    var result = await getReviewsController.reportReview(reviewId);
    if (result == "done") {
      Get.snackbar(
        "reportrevsuccess".tr,
        '',
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        icon: const Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
          size: 20,
        ),
        backgroundGradient: const LinearGradient(colors: [
          Colors.teal,
          Colors.green,
        ]),
      );
    } else {
      Get.snackbar(
        "deletereverror".tr,
        '',
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          FontAwesomeIcons.circleExclamation,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  void dispose() {
    getReviewsController.dispose();

    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("review".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'redex')),
          backgroundColor: Colors.white,
          elevation: 0,
          // toolbarHeight: 60,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
        ),
        body: CommentBox(
          withBorder: false,
          header: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 0))
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    "addreview".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i < 6; i++) ...[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              starCount = i;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            child: Icon(
                              FontAwesomeIcons.solidStar,
                              color: starCount < i
                                  ? secondaryColor.withOpacity(0.3)
                                  : secondaryColor,
                              size: 22,
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          commentController: commentController,
          userImage: appdataprefs!.getString("image") == "null"
              ? const AssetImage("assest/images/user.png") as ImageProvider
              : CachedNetworkImageProvider(appdataprefs!.getString("image")!),
          // sendButtonMethod: () {

          //     // Get.snackbar(
          //     //   "reviewerrortitle".tr,
          //     //   "reviewerror".tr,
          //     //   snackPosition: SnackPosition.TOP,
          //     //   backgroundColor: Colors.red.withOpacity(0.8),
          //     //   colorText: Colors.white,
          //     //   icon: Icon(
          //     //     FontAwesomeIcons.circleExclamation,
          //     //     color: Colors.white,
          //     //   ),
          //     // );

          // },
          backgroundColor: Colors.white,
          textColor: Colors.black,
          labelText:
              "${"commentby".tr} ${appdataprefs!.getString("fname")!} ${appdataprefs!.getString("lname")!}",

          sendWidget: GestureDetector(
            onTap: () {
              if (commentController.text.length > 8 &&
                  commentController.text.length < 400) {
                Get.dialog(AlertDialog(
                  elevation: 0,
                  backgroundColor: const Color(0xfff5f6f9),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.commentDots,
                        color: Color(0xff0FD481),
                        size: 60,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "reviewcreatesure".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 1; i < 6; i++) ...[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: starCount < i
                                      ? secondaryColor.withOpacity(0.3)
                                      : secondaryColor,
                                  size: 20,
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          commentController.text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff0FD481),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "no".tr,
                                  style: const TextStyle(
                                    color: Color(0xff0FD481),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              createReview(commentController.text, starCount);
                              commentController.clear();
                              setState(() {
                                starCount = 1;
                              });
                              Get.back();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xff0FD481),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "yes".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ));
              } else {
                Get.snackbar("reviewerrortitle".tr, "reviewerror".tr,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.black.withOpacity(0.7),
                    icon: const Icon(
                      FontAwesomeIcons.circleExclamation,
                      color: Colors.red,
                    ));
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: 40,
              child: const FaIcon(FontAwesomeIcons.share,
                  size: 30, color: secondaryColor),
            ),
          ),
          child: Obx(() => getReviewsController.reviewsInfo.isEmpty
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xff0FD481),
                    size: 50,
                  ),
                )
              : getReviewsController.reviewsInfo[0] == "notfound" ||
                      getReviewsController.reviewsInfo[0] == "error"
                  ? Center(child: notReviewAvilable("noreviewfound"))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0;
                              i < getReviewsController.reviewsInfo[0].length;
                              i++) ...[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: appdataprefs!.getString("userid") ==
                                        getReviewsController
                                            .reviewsInfo[0][i].user.id
                                    ? secondaryColor.withOpacity(0.1)
                                    : Colors.blueAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: Colors.grey.withOpacity(0.2),
                                //       spreadRadius: 2,
                                //       blurRadius: 2,
                                //       offset: Offset(0, 3))
                                // ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getReviewsController.reviewsInfo[0][i].user
                                              .imageUrl ==
                                          null
                                      ? SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.asset(
                                                  "assest/images/user.png")),
                                        )
                                      : SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: CachedNetworkImage(
                                              imageUrl: getReviewsController
                                                  .reviewsInfo[0][i]
                                                  .user
                                                  .imageUrl!,
                                              placeholder: (context, url) {
                                                return const BlurHash(
                                                  hash:
                                                      "L5H2EC=PM+yV0g-mq.wG9c010J}I",
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  getReviewsController
                                                          .reviewsInfo[0][i]
                                                          .user
                                                          .firstName +
                                                      " " +
                                                      getReviewsController
                                                          .reviewsInfo[0][i]
                                                          .user
                                                          .lastName,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                if (getReviewsController
                                                    .reviewsInfo[0][i]
                                                    .user
                                                    .isMerchant) ...{
                                                  const SizedBox(width: 5),
                                                  Image.asset(
                                                      "assest/images/check.png",
                                                      width: 17,
                                                      height: 17),
                                                }
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                if (getReviewsController
                                                        .reviewsInfo[0][i]
                                                        .rating <
                                                    5) ...{
                                                  for (int index = 0;
                                                      index <
                                                          5 -
                                                              getReviewsController
                                                                  .reviewsInfo[
                                                                      0][i]
                                                                  .rating;
                                                      index++) ...[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .solidStar,
                                                      color: secondaryColor
                                                          .withOpacity(0.3),
                                                      size: 12,
                                                    ),
                                                    const SizedBox(width: 2)
                                                  ]
                                                },
                                                for (int index = 0;
                                                    index <
                                                        getReviewsController
                                                            .reviewsInfo[0][i]
                                                            .rating;
                                                    index++) ...[
                                                  const Icon(
                                                    FontAwesomeIcons.solidStar,
                                                    color: secondaryColor,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 2)
                                                ],
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          getReviewsController
                                              .reviewsInfo[0][i].comment,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  appdataprefs!.getString("userid") ==
                                          getReviewsController
                                              .reviewsInfo[0][i].user.id
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              AlertDialog(
                                                elevation: 0,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.trash,
                                                      color: Colors.red,
                                                      size: 60,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      "deletecommet".tr,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      "deletecommentinfo".tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 80,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 1.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                "no".tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            removeReview(
                                                                getReviewsController
                                                                    .reviewsInfo[
                                                                        0][i]
                                                                    .id);
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 80,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                "yes".tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            alignment: Alignment.center,
                                            width: 50,
                                            child: const FaIcon(
                                              FontAwesomeIcons.trash,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              AlertDialog(
                                                elevation: 0,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons
                                                          .triangleExclamation,
                                                      color: Colors.blueGrey,
                                                      size: 60,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      "reportcomment".tr,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "reportcommentinfo".tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 80,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    width: 1.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                "no".tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            report(
                                                                getReviewsController
                                                                    .reviewsInfo[
                                                                        0][i]
                                                                    .id);
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 80,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .blueGrey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Text(
                                                                "yes".tr,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            alignment: Alignment.center,
                                            width: 50,
                                            child: const FaIcon(
                                              FontAwesomeIcons
                                                  .circleExclamation,
                                              color: Colors.blueGrey,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ],
                      ),
                    )),
        ));
  }
}
