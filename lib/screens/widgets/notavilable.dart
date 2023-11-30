import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget notAvilable(String message, double height) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(left: 12),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assest/images/notavilable.jpg",
          height: height,
        ),
        Text(
          message.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget notReviewAvilable(String message) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assest/images/noreviewavilable.jpg",
          height: 200,
        ),
        Text(
          message.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xff0DB770).withOpacity(0.8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
