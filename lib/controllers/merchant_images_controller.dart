import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:guide/main.dart';
import 'package:guide/models/classes/place_class.dart';
import 'package:http/http.dart' as http2;
import 'package:guide/views/local_vars.dart';
import 'package:http_parser/http_parser.dart';

class MerchantImagesController extends GetxController {
  RxList<dynamic> merchantImages = RxList<dynamic>();

  get http => null;

  getImages() async {
    merchantImages.clear();
    var url = Uri.parse('${serverUrl}/' /* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http2.get(
      url,
      headers: {"Authorization": header},
    );
    if (response.statusCode == 200 &&
        response.body.toString() != "[]" &&
        response.statusCode != 404) {
      var response2 = convertImageFromJson(response.body);
      for (var item in response2) {
        merchantImages.add(item);
      }
    } else if ((response.statusCode == 200 &&
            response.body.toString() == "[]") ||
        response.statusCode == 404) {
      merchantImages.add("noimages");
    } else {
      merchantImages.add("error");
    }
  }

  deleteImage(String imageid) async {
    var url = Uri.parse('${serverUrl}/' /* private-content */);
    var header = 'Bearer ${appdataprefs!.getString("token")}';
    var response = await http2.delete(
      url,
      headers: {"Authorization": header},
    );
    getImages();
    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
    } else {}
  }

  addImage(File image, String placeId) async {
    var url =
        Uri.parse('${serverUrl}/' /* private-content */);
    final token = 'Bearer ${appdataprefs!.getString("token")}';
    // Create a multipart request
    final request = http2.MultipartRequest('POST', url)
      ..headers['Authorization'] = token;

    // Load the image file
    final imageUri = Uri.file(image.path);
    final file = await http2.MultipartFile.fromPath(
      'images',
      imageUri.path,
      contentType: MediaType('image', 'jpeg'),
    );

    // Add the image file to the request
    request.files.add(file);

    final response = await request.send();

    if (response.statusCode == 200) {
      getImages();
      // return "done";
    } else if (response.statusCode == 403) {
      // return "userexist";
      // final responseBody = await response.stream.bytesToString();
    } else {
      // final responseBody = await response.stream.bytesToString();
    }
  }

  List<PlaceImage> convertImageFromJson(String str) => List<PlaceImage>.from(
      json.decode(str).map((x) => PlaceImage.fromJson(x)));

  String convertImageToJson(List<PlaceImage> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
