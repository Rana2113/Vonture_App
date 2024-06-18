class OpportunityModel {
  int? id;
  String? title;
  String? description;
  String? from;
  String? to;
  String? createdAt;
  Place? place;
  Host? host;
  List<String>? requirements;
  List<String>? offers;

  OpportunityModel({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.createdAt,
    this.place,
    this.host,
    this.requirements,
    this.offers,
  });

  OpportunityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    createdAt = json['createdAt'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    requirements = json['requirements'] != null
        ? List<String>.from(json['requirements'])
        : null;
    offers = json['offers'] != null ? List<String>.from(json['offers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['from'] = from;
    data['to'] = to;
    data['createdAt'] = createdAt;
    if (place != null) {
      data['place'] = place!.toJson();
    }
    if (host != null) {
      data['host'] = host!.toJson();
    }
    data['requirements'] = requirements;
    data['offers'] = offers;
    return data;
  }
}

class Place {
  int? id;
  String? name;
  String? pin;
  String? city;
  String? country;
  String? phoneNumber;
  double? rating;
  List<String>? placeMedia; // Adjusted to List<String>

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
    rating = (json['rating'] is int)
        ? (json['rating'] as int).toDouble()
        : json['rating'];
    if (json['placeMedia'] != null) {
      placeMedia = List<String>.from(json['placeMedia']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pin'] = pin;
    data['city'] = city;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['rating'] = rating;
    if (placeMedia != null) {
      data['placeMedia'] = placeMedia;
    }
    return data;
  }
}

class Media {
  String? url;
  String? type;

  Media({this.url, this.type});

  Media.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['type'] = type;
    return data;
  }
}

class Host {
  int? id;
  String? firstName;
  String? lastName;
  double? rating; // Adjusted to double

  Host({this.id, this.firstName, this.lastName, this.rating});

  Host.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    rating = (json['rating'] is int)
        ? (json['rating'] as int).toDouble()
        : json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['rating'] = rating;
    return data;
  }
}










// import 'host.dart';
// import 'place.dart';

// class OpportunityModel {
//   int? id;
//   String? title;
//   String? description;
//   String? from;
//   String? to;
//   DateTime? createdAt;
//   Place? place;
//   Host? host;
  

//   OpportunityModel({
//     this.id,
//     this.title,
//     this.description,
//     this.from,
//     this.to,
//     this.createdAt,
//     this.place,
//     this.host,
//   });

//   factory OpportunityModel.fromJson(Map<String, dynamic> json) {
//     return OpportunityModel(
//       id: json['id'] as int?,
//       title: json['title'] as String?,
//       description: json['description'] as String?,
//       from: json['from'] as String?,
//       to: json['to'] as String?,
//       createdAt: json['createdAt'] == null
//           ? null
//           : DateTime.parse(json['createdAt'] as String),
//       place: json['place'] == null
//           ? null
//           : Place.fromJson(json['place'] as Map<String, dynamic>),
//       host: json['host'] == null
//           ? null
//           : Host.fromJson(json['host'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'description': description,
//         'from': from,
//         'to': to,
//         'createdAt': createdAt?.toIso8601String(),
//         'place': place?.toJson(),
//         'host': host?.toJson(),
//       };
// }
