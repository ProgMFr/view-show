import 'dart:convert';

import 'package:guide/models/classes/place_class.dart';

import 'classes/profile_token_class.dart';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Profile data) => json.encode(data.toJson());
