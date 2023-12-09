import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/texts.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.hintText,
    required this.fielTitleTxt,
    this.suffixIcon,
  });

  final String hintText;
  final String fielTitleTxt;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            fielTitleTxt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 10),
          decoration: BoxDecoration(
              // color: Colors.green[100],
              borderRadius: BorderRadius.circular(10)),
          // color: colors['secondary'],
          height: 60,
          width: MediaQuery.of(context).size.width * 0.95,
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.green[50],
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: suffixIcon,
              // contentPadding: EdgeInsets.only(left: 10.0, top: 16.0),
              hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}
