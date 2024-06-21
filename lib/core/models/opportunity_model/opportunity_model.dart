import 'package:flutter/cupertino.dart';

import '../../../features/place/data/models/review_model/review.dart';

class OpportunityModel {
  int? id;
  String? title;
  String? description;
  String? from;
  String? to;
  String? status;
List<ReviewModel>? reviewModel;
  String? createdAt;
  Place? place;
  Host? host;
  List<String>? requirements;
  List<String>? offers;

  OpportunityModel({
    this.id,
    this.title,
    this.reviewModel,
    this.description,
    this.from,
    this.to,
    this.status,
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
    status = json['status'];
    createdAt = json['createdAt'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    reviewModel = json['touristReviews'] != null
        ? List<ReviewModel>.from(json['touristReviews'])
        : null;
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
    data['status'] = status;
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
  dynamic rating;
  List<String>? placeMedia;
  List<TouristReviews>? touristReviews;

  Place(
      {this.id,
        this.name,
        this.pin,
        this.city,
        this.country,
        this.phoneNumber,
        this.rating,
        this.placeMedia,
        this.touristReviews});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pin = json['pin'];
    city = json['city'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    rating = json['rating'];
    placeMedia = json['placeMedia'].cast<String>();
    if (json['touristReviews'] != null) {
      touristReviews = <TouristReviews>[];
      json['touristReviews'].forEach((v) {
        touristReviews!.add(new TouristReviews.fromJson(v));
      });
    }
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
    if (this.touristReviews != null) {
      data['touristReviews'] =
          this.touristReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TouristReviews {
  Tourist? tourist;
  dynamic rating;
  String? comment;
  String? createdAt;


  TouristReviews({this.tourist, this.rating, this.comment, this.createdAt});

  TouristReviews.fromJson(Map<String, dynamic> json) {
    tourist =
    json['tourist'] != null ? new Tourist.fromJson(json['tourist']) : null;
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tourist != null) {
      data['tourist'] = this.tourist!.toJson();
    }
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Tourist {
  int? id;
  String? firstName;
  String? lastName;

  Tourist({this.id, this.firstName, this.lastName});

  Tourist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
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
