class Host {
  int? id;
  String? firstName;
  String? lastName;
  String? email;

  Host({this.id, this.firstName, this.lastName, this.email});

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
}
