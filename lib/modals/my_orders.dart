
class MyOrders {
  String foodName;
  String category;
  String orderStatus;

  MyOrders({
    required this.foodName,
    required this.category,
    required this.orderStatus,
  });

  factory MyOrders.fromJson(Map<String, dynamic> json) => MyOrders(
    foodName: json["food_name"],
    category: json["category"],
    orderStatus: json["order_status"],
  );

  Map<String, dynamic> toJson() => {
    "food_name": foodName,
    "category": category,
    "order_status": orderStatus,
  };
}