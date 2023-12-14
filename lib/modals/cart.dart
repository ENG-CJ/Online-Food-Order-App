class Cart{
  String itemName,category,image;
  int price,quantity,total,originalPrice,foodID;

  Cart({
    required this.itemName,
    required this.foodID,
    required this.category,
    required this.image,
    required this.price,
    this.quantity=1,
    this.total=0,
    this.originalPrice=0
});


  factory Cart.fromJson(Map<String,dynamic> data){
    return Cart(foodID: data['food_id'],itemName: data['foodName'], category: data['cat'], image: data['image'], price: data['price']);
  }

}