import 'package:get/get.dart';
import 'package:guide/main.dart';
import '../services/login.dart';

class LoginController extends GetxController {
  loginbutton(int phonenumber, String password) async {
    var response1 = await LoginService().login(phonenumber, password);
    if (response1 == "error") {
      return "error";
    } else if (response1 == "notfound") {
      return "notfound";
    } else {
      appdataprefs!.setBool("islogin", true);
      appdataprefs!.setString("token", response1.token.accessToken.toString());
      appdataprefs!.setString("fname", response1.profile.firstName.toString());
      appdataprefs!.setString("email", response1.profile.email.toString());
      appdataprefs!.setString("lname", response1.profile.lastName.toString());
      appdataprefs!.setString("image", response1.profile.imageUrl.toString());
      appdataprefs!.setString("userid", response1.profile.id.toString());
      appdataprefs!
          .setString("phone", response1.profile.phoneNumber.toString());

      return "done";
    }
    // print(logininfo);
  }
}
