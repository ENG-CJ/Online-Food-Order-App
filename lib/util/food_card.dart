import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/modals/foods.dart';

import '../const/colors.dart';

class FoodCard extends StatelessWidget {
  final Foods foods;
  final bool? isFavoriteFood,hasFav;
  final void Function()? onclick;
  final void Function()? viewDetails;
  final void Function(Foods foods)? getData;
  const FoodCard(
      {super.key,
      required this.foods,
      this.onclick,
      this.getData,
      this.isFavoriteFood,this.hasFav=false,  this.viewDetails});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewDetails,
      child: Container(
        width: 160,
        height: 240,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              // BoxShadow(
              //   color: Color(0xFFdfdcdc).withOpacity(1),
              //   offset: Offset(0, 0),
              //   blurRadius: 26,
              //   spreadRadius: 3,
              // ),
            ]),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 8),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                  onTap: () {
                    if (getData != null) getData!(foods);
                  },
                  child: (isFavoriteFood?? false || hasFav!)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite,
                        )),
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage("$URL/uploads/${foods.image}"),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            foods.foodName,
            style: TextStyle(fontSize: 19, fontFamily: "Poppins Bold"),
          ),
          Text(
            foods.name,
            style: TextStyle(fontSize: 17, fontFamily: "Poppins Light"),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${foods.price}",
                  style: TextStyle(fontSize: 19, fontFamily: "Poppins Bold"),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                    onTap: onclick,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: colors['primary'],
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
