class Application {
  int? touristId;
  int? opportunityId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Tourist? tourist;
  Opportunity? opportunity;

  Application({
    this.touristId,
    this.opportunityId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.tourist,
    this.opportunity,
  });

  Application.fromJson(Map<String, dynamic> json) {
    touristId = json['touristId'];
    opportunityId = json['opportunityId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tourist =
        json['tourist'] != null ? Tourist.fromJson(json['tourist']) : null;
    opportunity = json['opportunity'] != null
        ? Opportunity.fromJson(json['opportunity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['touristId'] = touristId;
    data['opportunityId'] = opportunityId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (tourist != null) {
      data['tourist'] = tourist!.toJson();
    }
    if (opportunity != null) {
      data['opportunity'] = opportunity!.toJson();
    }
    return data;
  }
}

class Tourist {
  String? firstName;
  String? lastName;
  String? email;

  Tourist({this.firstName, this.lastName, this.email});

  Tourist.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}

class Opportunity {
  String? title;
  Place? place;
  String? from;
  String? to;

  Opportunity({this.title, this.place, this.from, this.to});

  Opportunity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (place != null) {
      data['place'] = place!.toJson();
    }
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}

class Place {
  String? name;

  Place({this.name});

  Place.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
