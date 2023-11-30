// To parse this JSON data, do
//
//     final getReviews = getReviewsFromJson(jsonString);

import 'dart:convert';

List<GetReviews> getReviewsFromJson(String str) =>
    List<GetReviews>.from(json.decode(str).map((x) => GetReviews.fromJson(x)));

String getReviewsToJson(List<GetReviews> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetReviews {
  String? id;
  User? user;
  String? placeId;
  String? comment;
  int? rating;

  GetReviews({
    this.id,
    this.user,
    this.placeId,
    this.comment,
    this.rating,
  });

  factory GetReviews.fromJson(Map<String, dynamic> json) => GetReviews(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        placeId: json["place_id"],
        comment: json["comment"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "place_id": placeId,
        "comment": comment,
        "rating": rating,
      };
}

class User {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  int? phoneNumber;
  String? imageUrl;
  bool? isMerchant;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.imageUrl,
    this.isMerchant,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        imageUrl: json["image_url"],
        isMerchant: json["is_merchant"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "image_url": imageUrl,
        "is_merchant": isMerchant,
      };
}
