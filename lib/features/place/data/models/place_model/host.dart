class Host {
  int? id;
  String? firstName;
  String? lastName;
  int? rating;

  Host({this.id, this.firstName, this.lastName, this.rating});

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        rating: json['rating'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'rating': rating,
      };
}
