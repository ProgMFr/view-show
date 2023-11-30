// To parse this JSON data, do
//
//     final getCity = getCityFromJson(jsonString);

import 'dart:convert';
import 'package:guide/models/classes/city_country_class.dart';
import 'package:guide/models/classes/place_class.dart';

GetCity getCityFromJson(String str) => GetCity.fromJson(json.decode(str));

String getCityToJson(GetCity data) => json.encode(data.toJson());

class GetCity {
  String? cityId;
  String? cityName;
  Country? country;
  List<Advertisement>? advertisements;
  List<LatestPlace>? latestPlaces;
  List<Place>? highestRatedPlaces;

  GetCity({
    this.cityId,
    this.cityName,
    this.country,
    this.advertisements,
    this.latestPlaces,
    this.highestRatedPlaces,
  });

  factory GetCity.fromJson(Map<String, dynamic> json) => GetCity(
        cityId: json["city_id"],
        cityName: json["city_name"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        advertisements: json["advertisements"] == null
            ? []
            : List<Advertisement>.from(
                json["advertisements"]!.map((x) => Advertisement.fromJson(x))),
        latestPlaces: json["latest_places"] == null
            ? []
            : List<LatestPlace>.from(
                json["latest_places"]!.map((x) => LatestPlace.fromJson(x))),
        highestRatedPlaces: json["highest_rated_places"] == null
            ? []
            : List<Place>.from(
                json["highest_rated_places"]!.map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
        "country": country?.toJson(),
        "advertisements": advertisements == null
            ? []
            : List<dynamic>.from(advertisements!.map((x) => x.toJson())),
        "latest_places": latestPlaces == null
            ? []
            : List<dynamic>.from(latestPlaces!.map((x) => x.toJson())),
        "highest_rated_places": highestRatedPlaces == null
            ? []
            : List<dynamic>.from(highestRatedPlaces!.map((x) => x.toJson())),
      };
}

class Advertisement {
  String? id;
  Country? country;
  String? image;
  String? title;
  String? shortDescription;
  String? url;
  Place? place;

  Advertisement({
    this.id,
    this.country,
    this.image,
    this.title,
    this.shortDescription,
    this.url,
    this.place,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
        id: json["id"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        image: json["image"],
        title: json["title"],
        shortDescription: json["short_description"],
        url: json["url"],
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country?.toJson(),
        "image": image,
        "title": title,
        "short_description": shortDescription,
        "url": url,
        "place": place?.toJson(),
      };
}

class LatestPlace {
  String? id;
  Country? country;
  Place? place;

  LatestPlace({
    this.id,
    this.country,
    this.place,
  });

  factory LatestPlace.fromJson(Map<String, dynamic> json) => LatestPlace(
        id: json["id"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country?.toJson(),
        "place": place?.toJson(),
      };
}
