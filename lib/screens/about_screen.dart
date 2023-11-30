import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("about".tr,
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
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xff0FD481),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                "assest/icon/icon.png",
                fit: BoxFit.contain,
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: const TextSpan(
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: "dubai"),
                    children: <TextSpan>[
                      // TextSpan(
                      //     text: "حول التطبيق\n",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20,
                      //       color: Color(0xff0FD481),
                      //     )),
                      TextSpan(
                          text:
                              'تطبيق view أداة رائعة لاستكشاف طبيعة وجمال العراق بالاضافة الى انه مهتم بالوجهات التي يسافر العراقيين اليها وتسهيل ترتيب الرحلات. يقدم هذا التطبيق الفرصة للعراقيين والزوار من جميع أنحاء العالم للتعرف على الجمال الفريد للبلاد والاستفادة من خدمات',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff0FD481),
                          )),
                      TextSpan(
                          text: "\n\nالخدمات المقدمة عبر التطبيق",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      TextSpan(
                          text: "\nحجوزات فندقية :\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "يقدم التطبيق خيارات متنوعة لحجز الفنادق في جميع أنحاء العراق. يمكنك اختيار الفئة المالية المناسبة والموقع المفضل والتواريخ المرغوبة.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\nحجز رحلات داخل العراق :\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "بفضل هذا التطبيق، يُمكنك حجز رحلات داخل العراق لاستكشاف وجهات متعددة، من الجبال إلى الصحاري والمدن التاريخية.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\nحجز رحلات خارج العراق :\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "إذا كنت ترغب في اكتشاف المزيد من الوجهات الدولية، يوفر التطبيق خيارات لحجز رحلات خارج العراق مع شركات سياحية موثوقة.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\nجولات سياحية وأنشطة :\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "يُقدم التطبيق أيضًا مجموعة متنوعة من الجولات السياحية والأنشطة الترفيهية، مما يساعدك على تخصيص تجربتك السياحية.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\nالاستفادة من تطبيق",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      TextSpan(
                        text: "  ڤيو - view\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff0FD481),
                        ),
                      ),
                      TextSpan(
                          text:
                              "من خلال استخدام التطبيق يمكن للمسافرين تجربة رحلات استكشافية مذهلة داخل البلاد وخارجها. من حجوزات الفنادق إلى الرحلات المنظمة والأنشطة الترفيهية، يُعد التطبيق أداة قوية تسهل تنظيم وتخطيط الرحلات بكل يسر وسلاسة. بفضل هذا التطبيق، يمكن للعراقيين والزوار الاستمتاع بتجربة سياحية لا تُنسى في واحدة من أكثر الوجهات إثراءً ثقافيًا وتاريخيًا في العالم.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
