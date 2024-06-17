class Requirements {
  int id;
  String name;

  Requirements({required this.id, required this.name});

  factory Requirements.fromJson(Map<String, dynamic> json) {
    return Requirements(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
