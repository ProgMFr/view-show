class City {
  String? id;
  String? cityName;
  Country? country;

  City({
    this.id,
    this.cityName,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        cityName: json["city_name"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
        "country": country?.toJson(),
      };
}

class Country {
  String? id;
  String? countryName;

  Country({
    this.id,
    this.countryName,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        countryName: json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_name": countryName,
      };
}
