import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_food_order_app/pages/home.dart';
import 'package:online_food_order_app/storage/local_storage.dart';
import 'package:online_food_order_app/util/info_content.dart';

import '../const/colors.dart';
import '../const/url.dart';
import '../modals/my_orders.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({super.key});

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  bool hasError = false;
  bool isLoadingData = true;
  bool authenticating = false;
  String errorDescr = "";
  List<MyOrders> myOrders=[];
  var dio = Dio();
  Future<void> loadMyOrders(id) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      Response response = await dio.get("$URL/orders/specificOrder/$id");
      if (response.data['status']) {
        print("yes");
        myOrders=(response.data['data'] as List).map((e) => MyOrders.fromJson(e)).toList();
        hasError = false;
        isLoadingData=false;
      } else {
        print("no");
        hasError = true;
        isLoadingData=false;
        errorDescr=response.data['description'];
      }

      setState(() {});
    } catch (e) {
      print("no2");
      hasError=true;
      isLoadingData=false;
      errorDescr=e.toString();
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalStorage().getId().then((value) {
      print("value is $value");
      loadMyOrders(value).then((value) {print(myOrders);});
      
    });

  }
  
  Widget builContentBody(List<MyOrders> orders){
      if(isLoadingData){
        return Center(child: CircularProgressIndicator(),);
      }
      if(hasError)
        return InfoContent(description: errorDescr, btnText: "Reload",click: (){
          LocalStorage().getId().then((value) {
            print(value);
            loadMyOrders(value).then((value) {print(myOrders);});

          });
        },);
      if(orders.length>0)
          return ListView.separated(itemBuilder: (_,index){

            return buildListOrderCard(orders[index]);
          }, separatorBuilder: (_,i)=>SizedBox(height: 8,), itemCount: orders.length);
      return InfoContent(description: "Currently, There are no orders placed.", btnText: "Order Now",click: (){
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Home()), (route) => false);
      },);
  }

  void checkNavigationStack(BuildContext context) {
    bool isNotEmpty = Navigator.of(context).canPop();

    if (isNotEmpty) {
      Navigator.pop(context);
    } else {
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['body-color'],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: ()=> checkNavigationStack(context),
                      child: FaIcon(FontAwesomeIcons.arrowLeft)),
                  SizedBox(width: 18,),
                  Text("My Orders",style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins Bold"
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Items",style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins Bold"
                  ),),
                  Text("Status",style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins Bold"
                  ),),

                ],
              ),
            ),
            Divider(),
            Expanded(child: builContentBody(myOrders))

          ],
        ),
      ),
    );
  }

  Widget buildListOrderCard(MyOrders order) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFf0e6e6).withOpacity(1),
                    offset: Offset(2, 4),
                    blurRadius: 11,
                    spreadRadius: 5,
                  ),

                ],
                  color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(14)
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.foodName,style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Poppins Bold"
                      ),),
                      Text(order.category,style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins Light"
                      ),),
                    ],
                  ),
                  order.orderStatus.toLowerCase()=="pending"?
                  Text(order.orderStatus,style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                      fontFamily: "Poppins Bold"
                  ),) :  Text(order.orderStatus,style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontFamily: "Poppins Bold"
                  ),)
                ],
              )
            ),
          );
  }
}
