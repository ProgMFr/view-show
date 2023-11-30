import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:guide/controllers/userreview_saved_controller.dart';
import 'package:guide/main.dart';
import 'package:guide/screens/widgets/notavilable.dart';
import 'package:guide/screens/widgets/placecard.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../../../views/local_vars.dart';

class UserBookmark extends StatefulWidget {
  const UserBookmark({super.key});

  @override
  State<UserBookmark> createState() => _UserBookmarkState();
}

class _UserBookmarkState extends State<UserBookmark> {
  late UserBookmarkController userBookmarkController;
  @override
  void initState() {
    userBookmarkController = Get.put(UserBookmarkController());
    userBookmarkController.getBookmarks();
    super.initState();
  }

  @override
  void dispose() {
    userBookmarkController.dispose();
    //
    super.dispose();
  }

  Future removeBookmark(id) async {
    Uri link = Uri.parse('${serverUrl}favorite_places/remove?place_id=$id');
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.delete(link, headers: {"Authorization": header});
    if (response.statusCode == 202) {
      debugPrint(response.statusCode.toString());
      setState(() {
        appdataprefs!.setString("$id", "delete");
        userBookmarkController.getBookmarks();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("bookmark".tr,
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
        body: Obx(() => userBookmarkController.userBookmarkInfo.isEmpty
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xff0FD481),
                  size: 50,
                ),
              )
            : userBookmarkController.userBookmarkInfo[0] == "notfound" ||
                    userBookmarkController.userBookmarkInfo[0] == "notfound"
                ? Center(child: notAvilable("", 250))
                : RefreshIndicator(
                    onRefresh: () async {
                      await userBookmarkController.getBookmarks();
                    },
                    backgroundColor: const Color(0xff0FD481),
                    color: Colors.white,
                    child: ListView.builder(
                        itemCount:
                            userBookmarkController.userBookmarkInfo.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: placeContainer(
                                    userBookmarkController
                                        .userBookmarkInfo[index],
                                    true),
                              ),
                              MaterialButton(
                                  onPressed: () {
                                    removeBookmark(userBookmarkController
                                        .userBookmarkInfo[index].id);
                                  },
                                  height: 45,
                                  minWidth: 45,
                                  elevation: 0,
                                  highlightElevation: 0,
                                  splashColor: Colors.red,
                                  shape: const CircleBorder(),
                                  color: Colors.red.withOpacity(0.1),
                                  child: const FaIcon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.red,
                                    size: 22,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          );
                        }),
                    // child: ListView.builder(
                    //   itemCount: userBookmarkController.userBookmarkInfo.length,
                    //   itemBuilder: (context, index) {
                    //     return Container(
                    //       margin: const EdgeInsets.symmetric(
                    //           vertical: 5, horizontal: 10),
                    //       child: Stack(
                    //         alignment: Alignment.center,
                    //         children: [
                    //           placeContainer(
                    //               userBookmarkController
                    //                   .userBookmarkInfo[index],
                    //               true),
                    //           Align(
                    //             alignment:
                    //                 appdataprefs!.getString("language") == "en"
                    //                     ? Alignment.centerLeft
                    //                     : Alignment.centerRight,
                    //             child: Container(
                    //               margin: const EdgeInsets.only(
                    //                   left: 30, right: 30),
                    //               child: MaterialButton(
                    //                   onPressed: () {
                    //                     removeBookmark(userBookmarkController
                    //                         .userBookmarkInfo[index]);
                    //                   },
                    //                   height: 50,
                    //                   minWidth: 50,
                    //                   elevation: 0,
                    //                   highlightElevation: 0,
                    //                   splashColor: Colors.red,
                    //                   shape: const CircleBorder(),
                    //                   color: Colors.white.withOpacity(0.6),
                    //                   child: const FaIcon(
                    //                     FontAwesomeIcons.trash,
                    //                     color: Colors.red,
                    //                     size: 22,
                    //                   )),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                  )));
  }
}
