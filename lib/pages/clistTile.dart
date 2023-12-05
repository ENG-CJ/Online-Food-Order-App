// import 'package:flutter/material.dart';

// class CustomListTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData leading;
//   final IconData t

//   CustomListTile({required this.title, required this.subtitle, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       subtitle: Text(subtitle),
//       onTap: () {
//         // Handle tile tap if needed
//         print('Tapped on $title');
//       },
//     );
//   }
// }


// // Example usage:


import 'package:flutter/material.dart';
import 'cText.dart';

class CustomListTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final IconData? trailing;
  // final VoidCallback onTap;


  CustomListTile({
    required this.leading,
    required this.title,
    this.trailing
  


   
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        ListTile(
              
              leading: SizedBox(width: 45,child: Icon(leading,size: 28,)),
              
              title: cText(text: title,textStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.w300),),
              horizontalTitleGap: 50,
              
              trailing: SizedBox(width: 73,child: Icon(trailing)) 
              
              
            ),
            
      ],
    );
  }

  }

