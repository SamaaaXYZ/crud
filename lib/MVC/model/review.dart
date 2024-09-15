class Review {
  late String id;
  late String review;
  late double stars;
  late String imageUrl;
  late String mealId;

  Review({
    required this.id,
    required this.review,
    required this.stars,
    required this.imageUrl,
    required this.mealId,
  });

  Map<String, dynamic> doc() {
    return {
      "review": review,
      "stars": stars,
      "imageUrl": imageUrl,
      "mealId": mealId,
    };
  }
}
