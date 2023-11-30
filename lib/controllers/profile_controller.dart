import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';
import 'package:http_parser/http_parser.dart';

import '../main.dart';
import '../views/local_vars.dart';

class ProfileController extends GetxController {
  RxList<dynamic> profileInfo = RxList<dynamic>();
  getProfile() async {
    profileInfo.clear();
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.get(
      url,
      headers: {"Authorization": header},
    );

    if (response.statusCode == 200) {
      var response2 = profileFromJson(response.body);
      appdataprefs!.setString("fname", response2.firstName.toString());
      appdataprefs!.setString("email", response2.email.toString());
      appdataprefs!.setString("lname", response2.lastName.toString());
      appdataprefs!.setString("image", response2.imageUrl.toString());
      appdataprefs!.setString("userid", response2.id.toString());
      appdataprefs!.setString("phone", response2.phoneNumber.toString());
      profileInfo.add(response2);

      if (response2.isMerchant == true) {
        return true;
      }
    } else if (response.statusCode == 403) {
      return "userexist";
    } else {
      return "error";
    }
  }

  uploadImage(File image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${serverUrl}'/* private-content */));
    request.files.add(await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType('image', 'jpeg')));
    request.headers.addAll(
        {"Authorization": 'Bearer ${appdataprefs!.getString("token")}'});
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      getProfile();
      return "done";
    } else if (response.statusCode == 403) {
      return "userexist";
    } else {
      return "error";
    }
  }

  changePass(String oldPass, String newPassword) async {
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.post(
      url,
      headers: {"Authorization": header},
      body:
          '{"old_password": "$oldPass","new_password1": "$newPassword","new_password2": "$newPassword"}',
    );

    if (response.statusCode == 200) {
      return "done";
    } else {
      return "error";
    }
  }

  editProfile(String fname, String lname, String email, String phone) async {
    int intphone = 0;
    if (phone.startsWith("0")) {
      intphone = int.parse(phone.replaceFirst("0", ""));
    } else {
      intphone = int.parse(phone);
    }
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.put(
      url,
      headers: {"Authorization": header},
      body:
          '{"first_name": "$fname","last_name": "$lname","email": "$email","phone_number":$intphone}',
    );
    var responsebody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getProfile();
      return "done";
    } else if (response.statusCode == 400 &&
        responsebody["message"] == "Phone number already exists.") {
      return "phoneexist";
    } else if (response.statusCode == 400 &&
        responsebody["message"] == "Email already exists.") {
      return "emailexist";
    } else {
      return "error";
    }
  }

  logout() async {
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.post(
      url,
      headers: {"Authorization": header},
    );

    if (response.statusCode == 200) {
      return "done";
    } else {
      return "error";
    }
  }
}

class MerchantController extends GetxController {
  RxList<dynamic> placeInfo = RxList<dynamic>();

  getPlace() async {
    placeInfo.clear();
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http.get(
      url,
      headers: {"Authorization": header},
    );
    if (response.statusCode == 200) {
      var response2 = placeFromJson(response.body);
      placeInfo.add(response2);
    } else if (response.statusCode == 404) {
      placeInfo.add("noplaceyet");
    } else {
      placeInfo.add("error");
    }
  }

  addplace(
    String name,
    String description,
    String phone,
    int price,
    String open,
    String facebook,
    String telegram,
    String whatsapp,
    String instagram,
    String address,
    String location,
    String cityid,
    String placeType,
    String type,
  ) async {
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var url = Uri.parse('${serverUrl}'/* private-content */);
    final Map<String, dynamic> data = {
      "user_id": "${appdataprefs!.getString("userid")}",
      "name": name,
      "city_id": cityid,
      "location": location,
      "short_location": address,
      "description": description,
      "price": price,
      "place_type": placeType,
      "type": type,
      "open": open,
      "phone_number": phone,
      "facebook": facebook == "string" ? null : facebook,
      "instagram": instagram == "string" ? null : instagram,
      "telegram": telegram == "string" ? null : telegram,
      "whatsapp": whatsapp == "string" ? null : whatsapp,
    };
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': header,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      getPlace();
      return "done";
    } else {
      return "error";
    }
  }

  editplace(
      String name,
      String description,
      String phone,
      int price,
      String open,
      String facebook,
      String telegram,
      String whatsapp,
      String instagram) async {
    var url = Uri.parse('${serverUrl}'/* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    final Map<String, dynamic> data = {
      "name": name,
      "description": description,
      "price": price,
      "open": open,
      "phone_number": phone,
      "facebook": facebook == "" ? null : facebook,
      "instagram": instagram == "" ? null : instagram,
      "telegram": telegram == "" ? null : telegram,
      "whatsapp": whatsapp == "" ? null : whatsapp,
    };

    final response = await http.put(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': header,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      getPlace();
      return "done";
    } else {
      return "error";
    }
  }
}
