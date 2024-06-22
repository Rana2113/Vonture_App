class PlaceModel {
  int? id;
  int? hostId;
  String? name;
  String? pin;
  String? city;
  String? country;
  String? phoneNumber;
  dynamic rating;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<String>? placeMedia;

  PlaceModel(
      {this.id,
      this.hostId,
      this.name,
      this.pin,
      this.city,
      this.country,
      this.phoneNumber,
      this.rating,
      this.status,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.placeMedia});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostId = json['hostId'];
    name = json['name'];
    pin = json['pin'];
    city = json['city'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    rating = json['rating'];
    status = json['status'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    placeMedia = json['placeMedia'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hostId'] = hostId;
    data['name'] = name;
    data['pin'] = pin;
    data['city'] = city;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['rating'] = rating;
    data['status'] = status;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['placeMedia'] = placeMedia;
    return data;
  }
}
