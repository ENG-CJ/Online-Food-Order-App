import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:online_food_order_app/const/colors.dart';

import '../util/button.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("asset/start.png"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome, Hilal",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins Bold"),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Fast Food",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins Bold",
                    color: colors['primary']),
              ),
            ],
          ),
          Text(
            "We’ve ready to serve you 24/7, ready to enjoy  best \ndelicious food and sweets, Order Now and Get now 😊.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontFamily: "Poppins Light"),
          ),
          SizedBox(height: 20),
          CButton(
            onClick: ()=> print("Hello"),
            widget: Center(
              child: Text(
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins Bold"),
                  "Explore Now"),
            ),
          )
        ],
      ),
    );
  }
}


