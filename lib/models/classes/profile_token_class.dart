class Profile {
  String id;
  String? email;
  String firstName;
  String lastName;
  int phoneNumber;
  String? imageUrl;
  bool isMerchant;
  bool isfree;
  String? dayToExpire;
  // bool isMerchant;

  Profile({
    required this.id,
    this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.imageUrl,
    required this.isMerchant,
    required this.isfree,
    this.dayToExpire,
    // required this.isMerchant,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        imageUrl: json["image_url"],
        isMerchant: json["is_merchant"],
        isfree: json["is_free"],
        dayToExpire: json["days_to_expire"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "image_url": imageUrl,
        "is_merchant": isMerchant,
        "is_free": isfree,
        "days_to_expire": dayToExpire,
        // "is_merchant": isMerchant,
      };
}

class Token {
  String accessToken;
  String tokenType;

  Token({
    required this.accessToken,
    required this.tokenType,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
