import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/pages/Login/login_page.dart';
import 'package:online_food_order_app/pages/Menu/nenu.details.dart';
import 'package:online_food_order_app/util/theme/theme.dart';

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
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home:  MenuDetails());
  }
}
