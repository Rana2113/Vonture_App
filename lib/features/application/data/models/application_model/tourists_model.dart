class TouristApplicationModel {
  Tourist? tourist;
  String? status;
  String? createdAt;

  TouristApplicationModel({this.tourist, this.status, this.createdAt});

  TouristApplicationModel.fromJson(Map<String, dynamic> json) {
    tourist =
        json['tourist'] != null ? Tourist.fromJson(json['tourist']) : null;
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tourist != null) {
      data['tourist'] = tourist!.toJson();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Tourist {
  int? id;
  String? firstName;
  String? lastName;
  String? bio;
  String? email;
  String? gender;
  String? nationality;
  String? birthdate;

  Tourist(
      {this.id,
      this.firstName,
      this.lastName,
      this.bio,
      this.email,
      this.gender,
      this.nationality,
      this.birthdate});

  Tourist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    email = json['email'];
    gender = json['gender'];
    nationality = json['nationality'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['bio'] = bio;
    data['email'] = email;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['birthdate'] = birthdate;
    return data;
  }
}
