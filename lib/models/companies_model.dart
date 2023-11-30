import 'dart:convert';

import 'classes/city_country_class.dart';
import 'classes/place_class.dart';
import 'classes/socialmedia_class.dart';

List<GetCompanies> getCompaniesFromJson(String str) => List<GetCompanies>.from(
    json.decode(str).map((x) => GetCompanies.fromJson(x)));

class GetCompanies {
  String? id;
  City? city;
  String? companyName;
  String? image;
  double? latitude;
  double? longitude;
  SocialMedia? socialMedia;
  String? companyDescription;

  GetCompanies({
    this.id,
    this.city,
    this.companyName,
    this.socialMedia,
    this.latitude,
    this.longitude,
    this.image,
    this.companyDescription,
  });

  factory GetCompanies.fromJson(Map<String, dynamic> json) => GetCompanies(
        id: json["id"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        companyName: json["company_name"],
        socialMedia: json["social_media"] == null
            ? null
            : SocialMedia.fromJson(json["social_media"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        companyDescription: json["company_description"],
      );
}

/// [company] model

GetCompany getCompanyFromJson(String str) =>
    GetCompany.fromJson(json.decode(str));

class GetCompany {
  GetCompanies? company;
  List<TripDetail>? tripDetails;

  GetCompany({
    this.company,
    this.tripDetails,
  });

  factory GetCompany.fromJson(Map<String, dynamic> json) => GetCompany(
        company: json["company"] == null
            ? null
            : GetCompanies.fromJson(json["company"]),
        tripDetails: json["trip_details"] == null
            ? []
            : List<TripDetail>.from(
                json["trip_details"]!.map((x) => TripDetail.fromJson(x))),
      );
}

class TripDetail {
  String? id;
  String? tripName;
  String? shortDescription;
  String? tripDetails;
  List<PlaceImage>? tripImages;

  TripDetail({
    this.id,
    this.tripName,
    this.shortDescription,
    this.tripDetails,
    this.tripImages,
  });

  factory TripDetail.fromJson(Map<String, dynamic> json) => TripDetail(
        id: json["id"],
        tripName: json["trip_name"],
        shortDescription: json["short_description"],
        tripDetails: json["trip_details"],
        tripImages: json["trip_images"] == null
            ? []
            : List<PlaceImage>.from(
                json["trip_images"]!.map((x) => PlaceImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trip_name": tripName,
        "short_description": shortDescription,
        "trip_details": tripDetails,
        "trip_images": tripImages == null
            ? []
            : List<dynamic>.from(tripImages!.map((x) => x.toJson())),
      };
}
