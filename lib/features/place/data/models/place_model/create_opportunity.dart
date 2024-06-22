class CreateOpportuntity {
  int? id;
  String? title;
  String? description;
  String? from;
  String? to;
  String? status;
  List<int>? offers;
  List<int>? requirements;
  Place? place;

  CreateOpportuntity({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.offers,
    this.requirements,
    this.place,
  });

  CreateOpportuntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    status = json['status'];

    offers = json['offers'] != null
        ? List<int>.from(json['offers'].map((offer) => _convertToInt(offer)))
        : [];
    requirements = json['requirements'] != null
        ? List<int>.from(json['requirements']
            .map((requirement) => _convertToInt(requirement)))
        : [];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['from'] = from;
    data['to'] = to;
    data['status'] = status;
    data['offers'] = offers;
    data['requirements'] = requirements;
    if (place != null) {
      data['place'] = place!.toJson();
    }
    return data;
  }

  int _convertToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }
}

class Place {
  int? id;
  String? name;
  String? pin;
  String? city;
  String? country;
  String? phoneNumber;
  dynamic rating;
  List<String>? placeMedia;

  Place({
    this.id,
    this.name,
    this.pin,
    this.city,
    this.country,
    this.phoneNumber,
    this.rating,
    this.placeMedia,
  });

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pin = json['pin'];
    city = json['city'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    rating = json['rating'];
    placeMedia = json['placeMedia'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pin'] = this.pin;
    data['city'] = this.city;
    data['country'] = this.country;
    data['phone_number'] = this.phoneNumber;
    data['rating'] = this.rating;
    data['placeMedia'] = this.placeMedia;

    return data;
  }
}
