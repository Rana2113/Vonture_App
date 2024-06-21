class ProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? nationality;
  String? bio;
  String? gender;
  String? birthdate;
  String? role;
  double? rating;
  String? createdAt;
  String? profileImg;

  String? updatedAt;
  List<Place>? place;
  List<ReceivedReviews>? receivedReviews;
  List<String>? skills;
  int? age;
  String? status;

  ProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.nationality,
    this.bio,
    this.profileImg,
    this.gender,
    this.birthdate,
    this.role,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.place,
    this.receivedReviews,
    this.skills,
    this.age,
    this.status,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profileImg = json['profile_img'];

    phoneNumber = json['phone_number'];
    nationality = json['nationality'];
    bio = json['bio'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    role = json['role'];
    rating = json['rating']?.toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    age = json['age'];
    status = json['status'] ?? '';

    if (json['place'] != null) {
      place = <Place>[];
      json['place'].forEach((v) {
        place!.add(Place.fromJson(v));
      });
    }
    if (json['receivedReviews'] != null) {
      receivedReviews = <ReceivedReviews>[];
      json['receivedReviews'].forEach((v) {
        receivedReviews!.add(ReceivedReviews.fromJson(v));
      });
    }
    skills = json['skills'] != null ? List<String>.from(json['skills']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['profile_img'] = profileImg;

    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['nationality'] = nationality;
    data['bio'] = bio;
    data['gender'] = gender;
    data['birthdate'] = birthdate;
    data['role'] = role;
    data['rating'] = rating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['age'] = age;
    data['status'] = status;

    if (place != null) {
      data['place'] = place!.map((v) => v.toJson()).toList();
    }
    if (receivedReviews != null) {
      data['receivedReviews'] =
          receivedReviews!.map((v) => v.toJson()).toList();
    }
    data['skills'] = skills;
    return data;
  }
}

class ReceivedReviews {
  GivenBy? givenBy;
  double? rating;
  String? comment;
  String? createdAt;

  ReceivedReviews({this.givenBy, this.rating, this.comment, this.createdAt});

  ReceivedReviews.fromJson(Map<String, dynamic> json) {
    givenBy =
        json['givenBy'] != null ? GivenBy.fromJson(json['givenBy']) : null;
    rating = json['rating']?.toDouble();
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (givenBy != null) {
      data['givenBy'] = givenBy!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    return data;
  }
}

class GivenBy {
  int? id;
  String? firstName;
  String? lastName;

  GivenBy({this.id, this.firstName, this.lastName});

  GivenBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class Place {
  Place.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    return {};
  }
}

class Skill {
  Skill.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    return {};
  }
}
