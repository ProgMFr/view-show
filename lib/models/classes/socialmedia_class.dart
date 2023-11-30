class SocialMedia {
  String? facebook;
  String? instagram;
  String? telegram;
  String? whatsapp;
  List<String>? isAvailable;

  SocialMedia({
    this.facebook,
    this.instagram,
    this.telegram,
    this.whatsapp,
    this.isAvailable,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        facebook: json["facebook"],
        instagram: json["instagram"],
        telegram: json["telegram"],
        whatsapp: json["whatsapp"],
        isAvailable: json["is_available"] == null
            ? []
            : List<String>.from(json["is_available"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "instagram": instagram,
        "telegram": telegram,
        "whatsapp": whatsapp,
        "is_available": isAvailable == null
            ? []
            : List<dynamic>.from(isAvailable!.map((x) => x)),
      };
}
