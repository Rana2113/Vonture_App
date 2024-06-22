import 'host.dart';

class Opportunity {
  int? id;
  String? title;
  String? description;
  String? from;
  String? to;
  Host? host;
  Place? place;

  Opportunity(
      {this.id,
      this.title,
      this.description,
      this.from,
      this.to,
      this.host,
      this.place});

  factory Opportunity.fromJson(Map<String, dynamic> json) => Opportunity(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        from: json['from'] as String?,
        to: json['to'] as String?,
        host: json['host'] == null
            ? null
            : Host.fromJson(json['host'] as Map<String, dynamic>),
        place: json['place'] == null
            ? null
            : Place.fromJson(json['place'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'from': from,
        'to': to,
        'host': host?.toJson(),
      };
}

class Place {
  List<String>? placeMedia;

  Place({this.placeMedia});

  Place.fromJson(Map<String, dynamic> json) {
    placeMedia = json['placeMedia'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeMedia'] = this.placeMedia;
    return data;
  }
}
