import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class InfoContent extends StatelessWidget {
  final String description,btnText;
  final double? imgWidth, imgH;
  final bool isCentered;
  final void Function()? click;
  const InfoContent({super.key,this.imgH,this.imgWidth,this.isCentered=false,required this.description,required this.btnText,this.click});

  @override
  Widget build(BuildContext context) {
    return  Center(

      child: isCentered? Padding(
        padding: const EdgeInsets.only(
            top: 100,
            left: 30,
            right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/no data.png",width: 210,),
            SizedBox(height: 10,),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins Bold"

                ),description),
            SizedBox(height: 20,),
            CButton(
                onClick: click,
                widget: Center(child: Text(btnText,style: TextStyle(color: Colors.white,fontFamily: "Poppins Bold"),),))

          ],
        ),
      )
      :Padding(
        padding: const EdgeInsets.only(
            top: 0,
            left: 10,
            right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/no data.png",width: imgWidth??210, height: imgH??240,),
            SizedBox(height: 10,),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins Bold"

                ),description),
            SizedBox(height: 20,),
            CButton(
                onClick: click,
                widget: Center(child: Text(btnText,style: TextStyle(color: Colors.white,fontFamily: "Poppins Bold"),),))

          ],
        ),
      )
      ,
    );
  }
}
