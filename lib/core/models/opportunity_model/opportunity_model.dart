import 'host.dart';
import 'place.dart';

class OpportunityModel {
  int? id;
  String? title;
  String? description;
  DateTime? from;
  DateTime? to;
  DateTime? createdAt;
  Place? place;
  Host? host;

  OpportunityModel({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.createdAt,
    this.place,
    this.host,
  });

  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    return OpportunityModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      place: json['place'] == null
          ? null
          : Place.fromJson(json['place'] as Map<String, dynamic>),
      host: json['host'] == null
          ? null
          : Host.fromJson(json['host'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'from': from?.toIso8601String(),
        'to': to?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'place': place?.toJson(),
        'host': host?.toJson(),
      };
}
