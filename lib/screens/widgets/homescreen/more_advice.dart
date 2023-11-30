import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homescreen/advicebutton.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  List advicelist = Get.arguments;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("recommed".tr,
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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: recommedB(advicelist[index], true),
          );
        },
        itemCount: advicelist.length,
        shrinkWrap: true,
      ),
    );
  }
}
