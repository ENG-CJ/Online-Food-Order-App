class Categories {
  int catId;
  String name;
  String description;

  Categories({
    required this.catId,
    required this.name,
    required this.description,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    catId: json["cat_id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "name": name,
    "description": description,
  };
}