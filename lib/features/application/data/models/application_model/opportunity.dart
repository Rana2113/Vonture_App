import 'host.dart';

class Opportunity {
  int? id;
  String? title;
  String? description;
  DateTime? from;
  DateTime? to;
  Host? host;

  Opportunity({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.host,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) => Opportunity(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        from: json['from'] == null
            ? null
            : DateTime.parse(json['from'] as String),
        to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
        host: json['host'] == null
            ? null
            : Host.fromJson(json['host'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'from': from?.toIso8601String(),
        'to': to?.toIso8601String(),
        'host': host?.toJson(),
      };
}
