import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/pages/signup.dart';
import './pages/favorites.dart';
import './pages/signup.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: colors['primary']));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SignUpPage(),
    );
  }
}
