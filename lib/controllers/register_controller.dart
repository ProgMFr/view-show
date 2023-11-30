import 'dart:convert';

import 'package:get/get.dart';
// import 'package:guide/main.dart';
import 'package:http/http.dart' as http;

import '../views/local_vars.dart';

class RegisterController extends GetxController {
  registerbutton(String fname, String lname, String email, int phonenumber,
      String password1, String password2) async {
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var response = await http.post(
      url,
      body:
          '{"first_name": "$fname","last_name": "$lname","email": "$email","phone_number": $phonenumber,"password1": "$password1","password2": "$password2"}',
    );
    var responsebody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return "done";
    } else if (response.statusCode == 403 &&
        responsebody["message"] ==
            "Forbidden, phone number is already registered") {
      return "phoneexist";
    } else if (response.statusCode == 403 &&
        responsebody["message"] == "Forbidden, email is already registered") {
      return "emailexist";
    } else {
      return "error";
    }
  }
}
