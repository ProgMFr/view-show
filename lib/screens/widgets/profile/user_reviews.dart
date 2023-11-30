import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/userreview_saved_controller.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserReviews extends StatefulWidget {
  const UserReviews({super.key});

  @override
  State<UserReviews> createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  late UserReviewController userReviewController;
  @override
  void initState() {
    userReviewController = Get.put(UserReviewController());
    userReviewController.getReviews();
    super.initState();
  }

  @override
  void dispose() {
    userReviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("myreview".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'redex')),
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0,
          // toolbarHeight: 60,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
        ),
        body: Obx(() => userReviewController.userReviewInfo.isEmpty
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xff0FD481),
                  size: 50,
                ),
              )
            : userReviewController.userReviewInfo[0] == "notfound" ||
                    userReviewController.userReviewInfo[0] == "error"
                ? Center(child: notReviewAvilable("noreview"))
                : RefreshIndicator(
                    onRefresh: () async {
                      await userReviewController.getReviews();
                    },
                    backgroundColor: const Color(0xff0FD481),
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: userReviewController.userReviewInfo.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: placeContainer(
                              userReviewController.userReviewInfo[index], true),
                        );
                      },
                    ),
                  )));
  }
}
