import 'package:flutter/material.dart';

class cText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  cText({required this.text, this.textStyle = const TextStyle()});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
