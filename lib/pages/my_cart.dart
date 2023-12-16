import 'package:alert_dialog/alert_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/pages/sucess_order.dart';
import 'package:online_food_order_app/util/cart_card.dart';

import '../const/url.dart';
import '../modals/cart.dart';
import '../modals/order.dart';
import '../util/button.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  var box = Hive.box("cart");
  var dio = Dio();
var _valueControler=TextEditingController();
  List<Cart> cart = [];
  List<Order> orders=[];
  var isLoading = true;

  Future<void> loadCartItems() async {
    try {
      cart = box.keys.map((key) {
        var cartItem = box.get(key);
        return Cart(
            foodID: cartItem['food_id'],
            originalPrice: cartItem['original'],
            itemName: cartItem['foodName'],
            category: cartItem['cat'],
            image: cartItem['image'],
            price: cartItem['price']);
      }).toList();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void deleteItem(index) {
    try {
      setState(() {
        box.deleteAt(index);
      });
    } catch (e) {
      print(e);
    }
  }


  Future<void> placeOrder()async{
    orders=cart.map((value) {
      return Order(foodID: value.foodID, quantity: value.quantity, order_date: DateFormat("yyyy-MM-dd").format(DateTime.now()), total_amount: value.price);
    }).toList();

    var jsonData = orders.map((order){
      var data = order.toJson();
      return data;
    }).toList();

    requestOrder(jsonData);
  }

var hasError=false;
var errorDescription='';
  Future<void> requestOrder(data) async{
    try{
      Response res= await dio.post("$URL/orders/placeOrder",data: data);
      if(!res.data['status']) {
        setState(() {
          hasError = true;
          errorDescription=res.data['description'];
        });
      }else{
        setState(() {
          hasError = false;

        });
      }
      
      print(res.data);
    }catch(e){
      print(e);
    }
  }

  var overAllTotal = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // box.clear();
    loadCartItems().then((value) {
      overAllTotal = 0;
      setState(() {
        overAllTotal = calculateTotalPrice(cart);
      });
    });
  }

  int calculateTotalPrice(List<Cart> cartItems) {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) total += cart[i].price;
    return total;
  }
  @override
Widget buildCartList(List<Cart> cartLit){
    if(cartLit.length>0)
       return  ListView.builder(
         itemCount: cart.length,
         itemBuilder: (_, index) {
           return CartCard(
               onDelete: () {
                 CoolAlert.show(context: context, type: CoolAlertType.confirm,
                 confirmBtnText: "Yes",
                   cancelBtnText: "No",
                   title: "Are you sure to remove this cart item from cart List?",
                   showCancelBtn: true,
                   onConfirmBtnTap: (){


                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${cart[index].itemName} Removed From Cart")));
                     deleteItem(index);
                     loadCartItems();
                     overAllTotal = calculateTotalPrice(cart);
                     setState(() {});
                   },

                 );

               },
               cart: cart[index],
               incr: (value) {
                 setState(() {
                   cart[index].quantity++;
                   cart[index].price =
                       cart[index].originalPrice * cart[index].quantity;
                   overAllTotal = calculateTotalPrice(cart);
                 });
               },
               decr: (value) {
                 if (cart[index].quantity == 0) return;
                 setState(() {
                   cart[index].quantity--;
                   cart[index].price =
                       cart[index].originalPrice * cart[index].quantity;
                   overAllTotal = calculateTotalPrice(cart);
                 });
               });
         },
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
       );

    return Center(

      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 30,
          right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/no data.png",width: 210,),
            SizedBox(height: 10,),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
              fontSize: 16,
                  fontFamily: "Poppins Bold"

            ),"We couldn't find any items in your cart. Please consider adding items to your cart now.!"),
            SizedBox(height: 20,),
            CButton(
                onClick: ()=> Navigator.pop(context),
                widget: Center(child: Text("Order Now",style: TextStyle(color: Colors.white,fontFamily: "Poppins Bold"),),))

          ],
        ),
      ),
    );
}
  @override
  Widget buildTotal(List<Cart> cartLit){
    if(cartLit.length>0)
      return    Padding(
        padding: const EdgeInsets.only(left: 20, top: 14, bottom: 10),
        child: Row(
          children: [
            Text(
              "Total : ",
              style: TextStyle(
                fontSize: 22,
                fontFamily: "Poppins Bold",
              ),
            ),
            Text(
              "\$${overAllTotal}",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Poppins Bold",
                  color: colors['primary']),
            ),
          ],
        ),
      );

    return SizedBox.shrink();
  }

  @override
  Widget buildButton(List<Cart> cartLit){
    if(cartLit.length>0)
      return    Padding(
        padding: const EdgeInsets.all(8.0),
        child: CButton(
          width: 380,
          onClick: () {
            alert(context,
                title: Text("Confirmation"),
                textOK: SizedBox.shrink(),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Would you like to proceed with placing this order ?"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CButton(
                          onClick: () {
                            Navigator.pop(context);
                            alert(context,
                                title: Text("Payment Action"),
                                textOK: SizedBox.shrink(),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "At present, the application doesn't support card payment gateways. The approval of this amount will be processed during the delivery. ?"),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    TextField(

                                      controller: TextEditingController(text: overAllTotal.toString()),
                                      readOnly: true,
                                      keyboardType:
                                      TextInputType.number,
                                      decoration: InputDecoration(

                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              top: 15,

                                            ),
                                            child: FaIcon(FontAwesomeIcons
                                                .dollarSign),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15),
                                              borderSide: BorderSide(
                                                  color:
                                                  colors['primary']
                                                  as Color)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15),
                                              borderSide: BorderSide(
                                                  color:
                                                  colors['primary']
                                                  as Color))),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CButton(
                                        onClick: () {

                                          placeOrder().then((value){
                                            if(hasError)
                                              alert(context,title: Text("Error During Order"), content: Text(errorDescription));
                                            else {

                                              Navigator.pop(context);
                                              box.clear();
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SuccessOrder()));
                                            }
                                          });


                                        },
                                        widget: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FaIcon(FontAwesomeIcons.gratipay),
                                                SizedBox(width: 10,),
                                                Text("Proceed"),
                                              ],
                                            )),
                                        width: double.maxFinite,
                                        radius: 16,
                                      ),
                                    )
                                  ],
                                ));
                          },
                          widget: Center(child: Text("Yes")),
                          width: 70,
                          height: 50,
                          radius: 16,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CButton(
                          onClick: () => Navigator.pop(context),
                          color: Color(0xffEF4040),
                          widget: Center(
                              child: Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              )),
                          width: 70,
                          height: 50,
                          radius: 16,
                        ),
                      ],
                    )
                  ],
                ));
          },
          widget: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins Bold"),
                    "Place Order"),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      );

    return SizedBox.shrink();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['body-color'],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9, top: 34, right: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Cart",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontFamily: "Poppins Bold",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Placed Items will appear here!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: "Poppins Light",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -19, end: 2),
                      badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      badgeContent: Text(cart.length.toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: colors['primary'],
                      ),
                    )
                  ],
                ),
              ),
             buildCartList(cart),
              buildTotal(cart),
              buildButton(cart),
            



              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
