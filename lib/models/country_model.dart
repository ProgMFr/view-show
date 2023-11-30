// To parse this JSON data, do
//
//     final countryHome = countryHomeFromJson(jsonString);

import 'dart:convert';

import 'package:guide/models/classes/ads_latesplace_class.dart';
import 'package:guide/models/classes/city_country_class.dart';

CountryHome countryHomeFromJson(String str) =>
    CountryHome.fromJson(json.decode(str));

String countryHomeToJson(CountryHome data) => json.encode(data.toJson());

class CountryHome {
  String? appVersion;
  String? androidUrl;
  String? iosUrl;
  String? countryId;
  String? countryName;
  List<City>? cities;
  List<Advertisement>? advertisements;
  List<LatestPlaceElement>? recommendedPlaces;
  List<LatestPlaceElement>? latestPlaces;
  List<Advertisement>? offers;
  List<CompaniesWithCity>? companiesWithCities;

  CountryHome({
    this.appVersion,
    this.androidUrl,
    this.iosUrl,
    this.countryId,
    this.countryName,
    this.cities,
    this.advertisements,
    this.recommendedPlaces,
    this.latestPlaces,
    this.offers,
    this.companiesWithCities,
  });

  factory CountryHome.fromJson(Map<String, dynamic> json) => CountryHome(
        appVersion: json["app_version"],
        androidUrl: json["android_link"],
        iosUrl: json["ios_link"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
        advertisements: json["advertisements"] == null
            ? []
            : List<Advertisement>.from(
                json["advertisements"]!.map((x) => Advertisement.fromJson(x))),
        recommendedPlaces: json["recommended_places"] == null
            ? []
            : List<LatestPlaceElement>.from(json["recommended_places"]!
                .map((x) => LatestPlaceElement.fromJson(x))),
        latestPlaces: json["latest_places"] == null
            ? []
            : List<LatestPlaceElement>.from(json["latest_places"]!
                .map((x) => LatestPlaceElement.fromJson(x))),
        offers: json["offers"] == null
            ? []
            : List<Advertisement>.from(
                json["offers"]!.map((x) => Advertisement.fromJson(x))),
        companiesWithCities: json["companies_with_cities"] == null
            ? []
            : List<CompaniesWithCity>.from(json["companies_with_cities"]!
                .map((x) => CompaniesWithCity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "app_version": appVersion,
        "android_link": androidUrl,
        "ios_link": iosUrl,
        "country_id": countryId,
        "country_name": countryName,
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
        "advertisements": advertisements == null
            ? []
            : List<dynamic>.from(advertisements!.map((x) => x.toJson())),
        "recommended_places": recommendedPlaces == null
            ? []
            : List<dynamic>.from(recommendedPlaces!.map((x) => x.toJson())),
        "latest_places": latestPlaces == null
            ? []
            : List<dynamic>.from(latestPlaces!.map((x) => x.toJson())),
        "offers": offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
        "companies_with_cities": companiesWithCities == null
            ? []
            : List<dynamic>.from(companiesWithCities!.map((x) => x.toJson())),
      };
}

class CompaniesWithCity {
  String? cityName;

  CompaniesWithCity({
    this.cityName,
  });

  factory CompaniesWithCity.fromJson(Map<String, dynamic> json) =>
      CompaniesWithCity(
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "city_name": cityName,
      };
}
