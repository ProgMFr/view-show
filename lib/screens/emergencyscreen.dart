import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("emer".tr,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            callBox("جهاز الامن الوطني", 131),
            callBox("مكافحة الابتزاز الالكتروني", 533),
            callBox("الدفاع المدني", 115),
            callBox("الاسعاف", 122),
            callBox("شرطة النجدة", 104),
            callBox("حماية الاسرة", 139),
            callBox("الشرطة المجتمعية", 497),
            callBox("جهاز المخابرات الوطني", 400),
            callBox("الاستخبارات العسكرية", 153),
            callBox("مديرية مكافحة الاجرام", 533),
            callBox("مديرية مكافحة المتفجرات", 404),
            callBox("عمليات الداخلية", 130),
            callBox("المساعدة المرورية", 455),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

Widget callBox(String name, int phone) {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
    padding: const EdgeInsets.symmetric(vertical: 5),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.squarePhone,
                  color: Colors.blue,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(phone.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
              ],
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse("tel:$phone"),
                mode: LaunchMode.externalApplication);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo, width: 1),
            ),
            child: const Row(
              children: [
                Text("اتصل الان",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    )),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  FontAwesomeIcons.phoneVolume,
                  color: Colors.indigo,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}
