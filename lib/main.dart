import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_food_order_app/const/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: colors['primary'])
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(child: TextButton(child: Text("Let's Start 😑👋"),onPressed: (){}),),
      ),
    );
  }
}

