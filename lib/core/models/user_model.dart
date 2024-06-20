class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? nationality;
  String? bio;
  String? gender;
  DateTime? birthdate;
  String? role;
  dynamic rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? toursitApplications;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.nationality,
    this.bio,
    this.gender,
    this.birthdate,
    this.role,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.toursitApplications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        phoneNumber: json['phone_number'] as String?,
        nationality: json['nationality'] as String?,
        bio: json['bio'] as String?,
        gender: json['gender'] as String?,
        birthdate: json['birthdate'] == null
            ? null
            : DateTime.parse(json['birthdate'] as String),
        role: json['role'] as String?,
        rating: json['rating'] as dynamic,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        toursitApplications: (json['touristApplications'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'nationality': nationality,
        'bio': bio,
        'gender': gender,
        'birthdate': birthdate?.toIso8601String(),
        'role': role,
        'rating': rating,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'toursitApplications': toursitApplications,
      };
}
