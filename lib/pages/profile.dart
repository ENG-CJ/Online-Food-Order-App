

import 'package:flutter/material.dart';
import '../pages/Eddit.dart';
import 'cText.dart';
import 'clistTile.dart';
void main(){
  runApp(
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:profile(),
      
    )
  );
}


class profile extends StatefulWidget {
  const profile({super.key});
  
 
  @override
  State<profile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<profile> {
  
  @override
  Widget build(BuildContext context) {
    

   
    
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
         
          children: [
            SizedBox(height: 50,),
            // AppBar(
            //   leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
            //   elevation: 0,
            //   title: cText(text: "Profile",textStyle: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
            //   centerTitle: true,
            //   backgroundColor: Colors.white,
            //   actions: [
               
                // Padding(
                //   padding: const EdgeInsets.only(top:11,right: 15),
                //   child: cText(text: "Edit",textStyle: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                // )
        
                // Padding(
                //   padding: const EdgeInsets.only(top:11,right: 15),
                //   child: TextButton(
                //     child: cText(text: "Edit",textStyle: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                //   onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => EdditPage()),
                //   );
                // },
                //   ),
                // )
        
        
        
              
        
        
            //   ],
            // ),
        
            Row(
              children: [
        
                SizedBox(width: 30,),
                Icon(Icons.arrow_back_ios,color: Colors.black,),
                SizedBox(width: 100,),
                cText(text: "Profile",textStyle: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                SizedBox(width: 110,),
                TextButton(
                  child: cText(text: "Edit",textStyle: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EdditPage()),
                );
                },
                )
        
        
              ],
            ),
        
            SizedBox(height: 16,),
            
            Stack(
              children: [
              // Container(     
              //     height: 135,
              //     width: 135,
              //     decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(70), 
              // image: DecorationImage(
              //   image: AssetImage("images/fit.jpg"),
              //   fit: BoxFit.cover,
                
        
              // )
        
              //     ),
              //   ),
             CircleAvatar(
              radius: 61.0,
              backgroundImage: AssetImage('images/Amiin.jpg'),
              backgroundColor: Colors.black,
              
            ),
        
                Padding(
                  padding: const EdgeInsets.only(left: 87,top: 83),
                  child: Container(
                    height: 45,
                    width: 45,
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                      BoxShadow(
                        // 0xd8c8c8
                        color: Color.fromARGB(0, 0, 0, 0).withOpacity(0.5),
                        offset: Offset(-3, 7),
                        blurRadius: 48,
                        spreadRadius: -3,
                        
                        
                  )]
                      
                     
                    ),
                                    
                    child: Icon(Icons.edit),
                  ),
                )
             
        
             
              ],
            ),
        
             SizedBox(height: 8,),
               cText(text: "Mohamed Amiin",textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                   SizedBox(height: 13,),
        
                   Container(
                    height: 515, ///440
                    width: 349,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      color: Colors.white,
        
                      boxShadow: [
                      BoxShadow(
                        color: Color(0xd8c8c8).withOpacity(1),
                        offset: Offset(1, 1),
                        blurRadius: 11,
                        spreadRadius: 1,
        
                  )
                      ]
                      
                    ),
                    // child: Row(
                      
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                       
                    //     // Icon(Icons.person),
                    //     // cText(text: "Settings"),
                    //     // Icon(Icons.arrow_forward_ios)
        
                    //     // ListTile(
                    //     //   leading: Icon(Icons.person),
                    //     //   title: cText(text: "Settings"),
                    //     //   trailing: Icon(Icons.arrow_forward_ios),
                    //     // )
                    //   ],
                    // ),
        
                   
        
                    child:   SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2,right: 10),
                            child: CustomListTile(leading:Icons.person,title: "Settings",trailing: Icons.arrow_forward_ios),
                          ),
                          Divider(thickness: 2,height: 10,indent: 15,endIndent: 20,),
                          SizedBox(height: 0,),
                          CustomListTile(leading:Icons.password,title: "Password",trailing: Icons.arrow_forward_ios),
                          Divider(thickness: 2,height: 10,indent: 15,endIndent: 20,),
                          CustomListTile(leading:Icons.phone,title: "Phone",trailing: Icons.arrow_forward_ios),
                          Divider(thickness: 2,height: 10,indent: 15,endIndent: 20,),
                          CustomListTile(leading:Icons.info,title: "Information",trailing: Icons.arrow_forward_ios),
                          Divider(thickness: 2,height: 10,indent: 15,endIndent: 20,),
                          CustomListTile(leading:Icons.logout,title: "Logout",),
                          Divider(thickness: 2,height: 10,indent: 15,endIndent: 20,),
                          SizedBox(height: 30,),
        
                          cText(text: "Joined at  2023/9/01")
                        
                        ],
                        
                      ),
                    ),
        
                    
                        
                   ),
                  
                  
        
        
          ],
          
        ),
      )

    );
  }

  
}