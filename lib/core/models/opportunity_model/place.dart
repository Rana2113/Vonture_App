class Place {
  int? id;
  String? name;
  String? pin;
  String? city;
  String? country;
  String? phoneNumber;
  double? rating;

  Place({
    this.id,
    this.name,
    this.pin,
    this.city,
    this.country,
    this.phoneNumber,
    this.rating,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json['id'] as int?,
        name: json['name'] as String?,
        pin: json['pin'] as String?,
        city: json['city'] as String?,
        country: json['country'] as String?,
        phoneNumber: json['phone_number'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pin': pin,
        'city': city,
        'country': country,
        'phone_number': phoneNumber,
        'rating': rating,
      };
}
