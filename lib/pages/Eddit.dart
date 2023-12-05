// import 'dart:html';

import 'package:flutter/material.dart';
import 'cText.dart';
import '../const/colors.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EdditPage(),
    )
  );
}

class EdditPage extends StatefulWidget {
  @override
  State<EdditPage> createState() => EdditPageState();
}

class EdditPageState extends State<EdditPage> {
  TextEditingController usernameController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Container(
    
      
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
          
             
              viewPage(),
            ],
          ),
        )
      ),
    );
  }

  Widget viewPage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          SizedBox(height: 70,),
    
          Row(
            children: [
    
              SizedBox(width: 20,),
      
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Color.fromRGBO(153, 219, 196, 1)
                ),
    
                child: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: IconButton(
                     onPressed: () {
                
                        Navigator.pop(context);
                  
                  },
                    icon:  Icon(Icons.arrow_back_ios,color: colors['primary'],size: 20,)),
                ),
              ),
              SizedBox(width: 15,),
              cText(text: "Edit My Profile",textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              
            ],
          ),
    
          SizedBox(height: 40,),
    
          Padding(
            padding: const EdgeInsets.only(left: 130),
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
               
               border: Border.all(color: Colors.green),
               image: DecorationImage(
                image:  AssetImage("images/Amiin.jpg"),
                fit: BoxFit.fitWidth
               )
              ),
            ),
          ),
    
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 43),
            child: cText(text: "FullName",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
           SizedBox(height: 10),
          first_inputField(usernameController,"Mohamed Amiin"),
           SizedBox(height: 20),
           Padding(
            padding: EdgeInsets.only(left: 43),
            child: cText(text: "Email",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
          ),
          SizedBox(height: 10),
          inputField(usernameController,"amiin@dev.email.com"),
            SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 43),
            child: cText(text: "Mobile",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
           SizedBox(height: 10),
          inputField(usernameController,"61XXXXXXX"),
           SizedBox(height: 20),
           Padding(
            padding: EdgeInsets.only(left: 43),
            child: cText(text: "Address",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          SizedBox(height: 10),
          inputField(usernameController,"Hilwaa, Muqdisho Somalia"),
    
           SizedBox(height: 10),
    
           Padding(
             padding: const EdgeInsets.only(left: 45, top: 20),
             child: Container(
              width: 340,
              height: 60,
              decoration: BoxDecoration(
                color: Color.fromRGBO(14, 190, 127, 1),
                borderRadius: BorderRadius.circular(10),
                
              ),
               child:  ElevatedButton(

                
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              
             
              
            
                ),
                
                onPressed: null, 
                child: cText(text: "Edit",textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
               ),
             ),
           ),

          
      

       


         
         
        ],
      ),
    );
  }



  Widget first_inputField(TextEditingController controller, String txt) {
      
    var border = OutlineInputBorder(
        borderRadius:  BorderRadius.circular(12),
        borderSide:  BorderSide());

    return Center(
      child: Padding(
      
        padding: const EdgeInsets.only(left: 40,right: 30),
        child: TextField(
          
          style:  TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            // fillColor: colors["secondary"],
            fillColor: Color.fromRGBO(14, 190, 127, 0.1),
            hintText: txt,
            hintStyle: const TextStyle(color: Colors.black,fontSize: 17),
            

           
            
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromRGBO(14, 190, 127, 1)
              )
            ),
            
            focusedBorder: border,
          ),
          // obscureText: isPassword,
        ),
      ),
    );
  }

    Widget inputField(TextEditingController controller, String txt) {
      
    var border = OutlineInputBorder(
        borderRadius:  BorderRadius.circular(12),
        borderSide:  BorderSide());

    return Center(
      child: Padding(
      
        padding: const EdgeInsets.only(left: 40,right: 30),
        child: TextField(
          
          style:  TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            // fillColor: colors["secondary"],
            fillColor: Color.fromRGBO(14, 190, 127, 0.1),
            hintText: txt,
            hintStyle: const TextStyle(color: Colors.black,fontSize: 17),
            

           
            
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),
            
            focusedBorder: border,
          ),
          // obscureText: isPassword,
        ),
      ),
    );
  }
}