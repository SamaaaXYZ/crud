class Meal {
  late String id;
  late String name;
  late String de_name;
  late String type;
  late String de_type;
  late double price;
  late String imageUrl;

  Meal({
    required this.id,
    required this.name,
    required this.de_name,
    required this.price,
    required this.type,
    required this.de_type,
    required this.imageUrl,
  });

  Map<dynamic, dynamic> doc() {
    return {
      "name": name,
      "de_name": de_name,
      "price": price,
      "type": type,
      "de_type": de_type,
      "imageUrl": imageUrl,
    };
  }
}
