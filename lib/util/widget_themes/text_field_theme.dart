import 'package:flutter/material.dart';
import 'package:online_food_order_app/const/colors.dart';

class TTextFormFieldFieldTheme {

  TTextFormFieldFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
       InputDecorationTheme(
        border: const OutlineInputBorder(),
        prefixIconColor: colors['secondary'],
        floatingLabelStyle: TextStyle(color: colors['secondary']),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: colors['secondary'] ?? const Color(0xff0EBE7F))
        )
      );
  static InputDecorationTheme darkInputDecorationTheme =
   InputDecorationTheme(
      border: const OutlineInputBorder(),
      prefixIconColor: colors['primary'],
      floatingLabelStyle: TextStyle(color: colors['primary']),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: colors['primary'] ?? const Color(0xff0EBE7F))
      )
  );
}