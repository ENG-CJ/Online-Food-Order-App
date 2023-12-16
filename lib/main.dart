import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/pages/Login/login_page.dart';
import 'package:online_food_order_app/pages/Menu/nenu.details.dart';
import 'package:online_food_order_app/pages/favorites.dart';
import 'package:online_food_order_app/pages/home.dart';
import 'package:online_food_order_app/pages/product_lists.dart';
import 'package:online_food_order_app/pages/your_orders.dart';
void main() async{
  await Hive.initFlutter();
  await Hive.openBox("cart");
  await Hive.openBox("fav");
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: colors['primary']));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
