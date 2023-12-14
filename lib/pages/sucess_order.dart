import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_food_order_app/pages/home.dart';
import 'package:online_food_order_app/util/button.dart';

class SuccessOrder extends StatelessWidget {
  const SuccessOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("asset/order-success.png"),
              Text("Thank You 🥰", style: TextStyle(fontSize: 28,
              fontFamily: "Poppins Bold"),) ,
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20
                ),
                child: Text(" Your satisfaction is our priority, and we look forward to serving you again soon. Thank you once again for choosing us.", style: TextStyle(fontSize: 16,
                fontFamily: "Poppins Light"),),
                
                
              ),
              SizedBox(height: 17,),
              CButton(
                  onClick: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Home()), (route) => false),
                  widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                FaIcon(FontAwesomeIcons.cartShopping,color: Colors.white,),
                SizedBox(width: 10,),
                Text("Order Again ",style: TextStyle(fontSize: 16,
                    fontFamily: "Poppins Bold",color: Colors.white))
              ],))
            ],
          ),
        ),
      ),
    );
  }
}
