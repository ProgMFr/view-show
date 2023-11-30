// To parse this JSON data, do
//
//     final signin = signinFromJson(jsonString);

import 'dart:convert';

import 'package:guide/models/classes/profile_token_class.dart';

Signin signinFromJson(String str) => Signin.fromJson(json.decode(str));

String signinToJson(Signin data) => json.encode(data.toJson());

class Signin {
  Profile profile;
  Token token;

  Signin({
    required this.profile,
    required this.token,
  });

  factory Signin.fromJson(Map<String, dynamic> json) => Signin(
        profile: Profile.fromJson(json["profile"]),
        token: Token.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "token": token.toJson(),
      };
}
