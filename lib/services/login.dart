// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import '../models/sign_model.dart';
import '../views/local_vars.dart';

class LoginService {
  var url = Uri.parse('${serverUrl}/' /* private-content */);

  login(int phone, String password) async {
    var response = await http.post(
      url,
      body: '{"phone_number": $phone,"password": "$password"}',
    );

    if (response.statusCode == 200) {
      var latescode = signinFromJson(response.body);
      return latescode;
    } else if (response.statusCode == 404) {
      return "notfound";
    } else {
      return "error";
    }
  }
}
