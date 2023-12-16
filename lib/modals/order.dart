class Order{

  int? orderID;
  int? custID;
  int foodID;
  int quantity;
  int total_amount;
  String order_date;

  Order({
    this.orderID,
    this.custID,
   required this.foodID,
   required  this.quantity,
    required this.order_date,
   required  this.total_amount
});

  factory Order.fromJson(Map<String,dynamic> json){
    return Order(foodID: json['food_id'], quantity: json['quantity'], order_date: json['orderDate'], total_amount: json['total_amount']);
  }


  Map<String,dynamic> toJson(){
    return {
      "food_id": foodID,
      "custID": custID,
      "quantity": quantity,
      "total_amount": total_amount,
      "order_date": order_date
    };
  }


}