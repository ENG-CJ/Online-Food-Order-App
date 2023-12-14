class Foods {
  int id;
  String foodName;
  int price;
  int categoryId;
  String image;
  String status;
  int catId;
  String name;
  String description;

  Foods({
    required this.id,
    required this.foodName,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.status,
    required this.catId,
    required this.name,
    required this.description,
  });

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
    id: json["id"],
    foodName: json["food_name"],
    price: json["price"],
    categoryId: json["category_id"],
    image: json["image"],
    status: json["status"],
    catId: json["cat_id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "food_name": foodName,
    "price": price,
    "category_id": categoryId,
    "image": image,
    "status": status,
    "cat_id": catId,
    "name": name,
    "description": description,
  };
}