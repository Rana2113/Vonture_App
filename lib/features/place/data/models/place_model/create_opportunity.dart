class CreateOpportuntity {
  int? id;
  String? title;
  String? description;
  String? from;
  String? to;
  String? status;

  List<int>? offers;
  List<int>? requirements;

  CreateOpportuntity({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.offers,
    this.requirements,
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
