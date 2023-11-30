import 'package:guide/models/classes/city_country_class.dart';
import 'package:guide/models/classes/place_class.dart';

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

class LatestPlaceElement {
  String? id;
  Country? country;
  Place? place;

  LatestPlaceElement({
    this.id,
    this.country,
    this.place,
  });

  factory LatestPlaceElement.fromJson(Map<String, dynamic> json) =>
      LatestPlaceElement(
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
