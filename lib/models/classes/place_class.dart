import 'package:guide/models/classes/city_country_class.dart';
import 'package:guide/models/classes/socialmedia_class.dart';

class Place {
  String? id;
  String? name;
  City? city;
  double? longitude;
  double? latitude;
  String? description;
  String? shortLocation;
  double? price;
  List<PlaceImage>? placeImages;
  SocialMedia? socialMedia;
  String? type;
  String? subtype;
  double? averageRating;
  int? reviewCount;
  String? available;
  String? phoneNumber;

  Place({
    this.id,
    this.name,
    this.city,
    this.longitude,
    this.latitude,
    this.description,
    this.shortLocation,
    this.price,
    this.placeImages,
    this.socialMedia,
    this.type,
    this.subtype,
    this.averageRating,
    this.reviewCount,
    this.available,
    this.phoneNumber,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        name: json["name"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        longitude: json["longitude"],
        latitude: json["latitude"],
        description: json["description"],
        shortLocation: json["short_location"],
        price: json["price"],
        placeImages: json["place_images"] == null
            ? []
            : List<PlaceImage>.from(
                json["place_images"]!.map((x) => PlaceImage.fromJson(x))),
        socialMedia: json["social_media"] == null
            ? null
            : SocialMedia.fromJson(json["social_media"]),
        type: json["place_type"],
        subtype: json["type"],
        averageRating: json["average_rating"],
        reviewCount: json["review_count"],
        available: json["open"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city?.toJson(),
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "short_location": shortLocation,
        "price": price,
        "place_images": placeImages == null
            ? []
            : List<dynamic>.from(placeImages!.map((x) => x.toJson())),
        "social_media": socialMedia?.toJson(),
        "type": type,
        "subtype": subtype,
        "average_rating": averageRating,
        "review_count": reviewCount,
        "available": available,
        "phone_number": phoneNumber,
      };
}

class PlaceImage {
  String? id;
  String? image;
  String? imageUrl;

  PlaceImage({
    this.id,
    this.image,
    this.imageUrl,
  });

  factory PlaceImage.fromJson(Map<String, dynamic> json) => PlaceImage(
        id: json["id"],
        image: json["image"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "image_url": imageUrl,
      };
}
