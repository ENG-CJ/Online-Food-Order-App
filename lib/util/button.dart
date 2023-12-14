import 'package:flutter/material.dart';

import '../const/colors.dart';

class CButton extends StatelessWidget {
  final void Function()? onClick;
  final double? width,height, padding,radius;
  final Color? color;
  final Widget widget;
  const CButton({
    super.key,
    required this.widget,
    this.onClick,
    this.width,
    this.height,
    this.padding,
    this.radius,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          width: width??279,
          height: height??64,
          decoration: BoxDecoration(
              color: color??colors['primary'],
              borderRadius: BorderRadius.circular(radius??17)),
          child:widget
      ),
    );
  }
}