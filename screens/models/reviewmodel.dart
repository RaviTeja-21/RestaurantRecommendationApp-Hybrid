class ReviewModel {
  String? userId;
  String? review;
  double? rating;

  ReviewModel(
    this.userId,
    this.review,
    this.rating,
  );

  ReviewModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    review = json['review'];
    rating = json['rating'];
  }
}

