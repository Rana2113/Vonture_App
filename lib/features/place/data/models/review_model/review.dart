class ReviewModel {
  int? receivedById;
  int? givenById;
  dynamic rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  ReviewModel(
      {this.receivedById,
      this.givenById,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    receivedById = json['receivedById'];
    givenById = json['givenById'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receivedById'] = receivedById;
    data['givenById'] = givenById;
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
