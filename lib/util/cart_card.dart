import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/modals/cart.dart';

import '../const/colors.dart';

class CartCard extends StatelessWidget {
  final Cart cart;
  final void Function(int? value)? incr,decr;
  final void Function()? onDelete;

  final void Function()? onClick;
  const CartCard({super.key, required this.cart,this.onClick, this.incr,this.decr,this.onDelete});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          top: 20,
          bottom: 8
      ),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [

              BoxShadow(
                color: Color(0xFFe5e5e5).withOpacity(1),
                offset: Offset(0, 2),
                blurRadius: 31,
                spreadRadius: 0,
              ),

            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(18)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(borderRadius: BorderRadius.circular(17),child: Image.network("$URL/uploads/${cart.image}")),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 13,
                  left: 20,
                  right: 16
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cart.itemName,style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins Bold"
                      ),),
                      Text(cart.category,style: TextStyle(
                          fontSize: 14,

                          fontFamily: "Poppins Light"
                      ),)
                    ],
                  ),
                  Row(

                    children: [
                      InkWell(
                        onTap: (){
                          if(incr!=null)
                            incr!(cart.price);
                        },
                        child: Container(
                          width: 32,
                          height: 33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: colors['primary']!.withOpacity(0.3)
                          ),
                          child: Center(child: Text("+",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          )
                          ),


                        ),
                      ),
                      SizedBox(width: 8,),
                      Text(cart.quantity.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap:  (){
                          if(decr!=null)
                            decr!(cart.price);
                        },
                        child: Container(
                          width: 32,
                          height: 33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: colors['primary']!.withOpacity(0.3)
                          ),
                          child: Center(child: Text("-",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          )
                          ),


                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20,
                  right: 17,
                  bottom: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${cart.price}",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Poppins Bold",
                        color: colors['primary']
                    ),),
                  InkWell(onTap: onDelete,child: Icon(Icons.close, size: 40,color: Colors.redAccent,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
