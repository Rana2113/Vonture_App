class Offers {
  int? id;
  String? name;

  Offers({this.id, this.name});

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
