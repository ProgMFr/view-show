import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("terms".tr,
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
                      TextSpan(
                          text: "سياسة استخدام التطبيق\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff0FD481),
                          )),
                      TextSpan(
                          text:
                              'مرحبًا بك في تطبيق view, يُرجى قراءة هذه السياسة بعناية قبل استخدام التطبيق. من خلال استخدامك لهذا التطبيق، فإنك توافق على الالتزام بشروط استخدامنا وسياساتنا. في حال عدم موافقتك على هذه الشروط، يُنصح بعدم استخدام التطبيق.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                      TextSpan(
                          text: "\n\n1. هدف التطبيق \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "تطبيقنا السياحي هو منصة إلكترونية تهدف إلى توفير معلومات سياحية وتسهيل عمليات حجز الفنادق والرحلات الداخلية والخارجية والأنشطة السياحية ، بالاضافة الى توفير بيئة متكاملة من الاشياء التي يمكن ان يحتاجها السائح خلال فترة اقامته داخل اي بلد .",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n2. المستخدمين المستهدفين\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "هذا التطبيق متاح لجميع الأفراد الذين يرغبون في تصفح المعلومات السياحية أو القيام بعمليات حجز سياحي.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n3. الشروط والقوانين\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "عند استخدامك للتطبيق، يجب عليك الامتثال للقوانين واللوائح المحلية والدولية ذات الصلة. يُمنع استخدام التطبيق لأي أغراض غير قانونية أو غير أخلاقية.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n4. النشاط التجاري \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "اضافة نشاطك التجاري داخل التطبيق يمكّن المستخدمين من زيارة المكان واضافة التقيمات والتعليقات ويمكنك ايضاً حذف او ارشفة نشاطك التجاري.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n5. البيانات الشخصية والخصوصية\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "المعلومات التي سوف تقوم بالتسجيل بها داخل التطبيق يجب ان تكون حقيقية وفي حال كانت معلومات لشخص اخر قد يعرضك ذلك الى المسائلة القانونية بسبب انتحال شخصية ،نحن نحترم خصوصية معلوماتك الشخصية. حيث يتم التحفظ على كافة معلوماتك المسجلة داخل التطبيق .",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n6. عمليات الدفع والتسعير\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "أثناء إجراء عمليات الدفع من خلال التطبيق، يجب أن تقدم معلومات دقيقة وصحيحة. سيتم تحصيل الرسوم وفقًا للأسعار المعلنة في التطبيق وسياسة التسعير الخاصة بنا.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n7. المسؤولية\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "نحن غير مسؤولين عن أي تأخير أو مشكلة ناجمة عن استخدام التطبيق أو عدم القدرة على استخدامه، بما في ذلك تأخيرات في الحجوزات أو تغييرات في الخدمات المقدمة.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n8. تحديثات التطبيق\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "نحتفظ بالحق في تحديث التطبيق وإجراء تعديلات على الوظائف والميزات بدون إشعار مسبق. يُفضل مراجعة التطبيق بانتظام للبقاء على اطلاع بآخر التحديثات.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n9. تغييرات في سياسة الاستخدام\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "قد نجري تعديلات على سياسة استخدام التطبيق من وقت لآخر. سيتم نشر أي تحديثات جديدة هنا. يُفضل مراجعة هذه الصفحة بانتظام.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "\n\n10. تواصل معنا\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "للتواصل مع فريق دعم العملاء أو لتقديم ملاحظاتك واقتراحاتك، يُرجى استخدام معلومات الاتصال المتاحة في التطبيق.",
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
