
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_food_order_app/storage/local_storage.dart';
import 'package:online_food_order_app/util/button.dart';
import 'package:online_food_order_app/validations.dart';
import '../const/url.dart';
import '../modals/user.dart';
import '../widgets/text_field.dart';
import 'cText.dart';
import '../const/colors.dart';

class EdditPage extends StatefulWidget {
  final User user;
  final void Function()? onLoad;
  const EdditPage({super.key, required this.user,this.onLoad});

  @override
  State<EdditPage> createState() => EdditPageState();
}

class EdditPageState extends State<EdditPage> {
  // TextEditingController usernameController = TextEditingController(text: widget.user.username);
  var username='';
  var email='';
  var mobile=0;
  var address='';
  void loadData(){
     username=widget.user.username;
     email=widget.user.email;
     mobile=widget.user.mobile;
     address=widget.user.address;
     setState(() {

     });
  }
  bool hasError = false;
  bool isUpdating = false;
  String errorDescr = "";

  var dio = Dio();
  bool hasData = false;


  Future<void> update(User user) async {
    setState(() {
      isUpdating = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));
      Response response =
      await dio.post("$URL/customers/updateFromClient", data: user.toJson());
      if (response.data['status']) {
        print(response.data);
        setState(() {
          hasError = false;
          isUpdating=false;
        });
      } else {
        setState(() {
          hasError = true;
          isUpdating=false;
          errorDescr = response.data['description'];
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorDescr = e.toString();
        isUpdating = false;
      });
    }
    setState(() {
      isUpdating = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isUpdating,
      child: Container(
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
                image:  AssetImage("asset/avatar.png"),
                fit: BoxFit.fitWidth
               )
              ),
            ),
          ),
    
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(
                left: 30,
                bottom: 17
            ),
            child: CustomField(
              value: username,
              onTextChange: (value) {
                username=value;
              },
              fielTitleTxt: "FullName",
              hintText: "Your FullName",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30,
                bottom: 17
            ),
            child: CustomField(
              value: email,
              onTextChange: (value) {
email=value;
              },
              fielTitleTxt: "Email",
              hintText: "Email",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30,
                bottom: 17
            ),
            child: CustomField(
              value: mobile.toString(),
              inputType: TextInputType.number,
              onTextChange: (value) {
                mobile=int.parse(value);
              },
              fielTitleTxt: "Mobile",
              hintText: "61xxxxxx",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30,
                bottom: 17
            ),
            child: CustomField(
              value: address,
              onTextChange: (value) {
                address=value;
              },
              fielTitleTxt: "Address",
              hintText: "Hodan xxxx",
            ),
          ),
           SizedBox(height: 10),
    
           Padding(
             padding: const EdgeInsets.only(left: 40, top: 20,right: 10),
             child: CButton(
                 width: double.maxFinite,
                 onClick: (){

               if(mobile==0 || username=="" || address=="" || email==""){
                 CoolAlert.show(context: context, type: CoolAlertType.error,
                   title: "Error",
                   text: "Provide Required Data",
                 );
                 return;
               }
               if(!Validator().isFullNameValid(username)){
                 CoolAlert.show(context: context, type: CoolAlertType.error,
                   title: "Error",
                   text: "Name must be Valid FullName",
                 );
                 return;
               }

               if(!Validator().containsOnlyLettersAndSpaces(username)){
                 CoolAlert.show(context: context, type: CoolAlertType.error,
                   title: "Error",
                   text: "FullName Must conatain only alphabetic and space char",
                 );
                 return;
               }

               if(!Validator().isEmailValid(email)){
                 CoolAlert.show(context: context, type: CoolAlertType.error,
                   title: "Error",
                   text: "Incorrect Email Format, use format -> example@gmail.com",
                 );
                 return;
               }

               var user = User(username: username, email: email, password: widget.user.password, mobile: mobile, address: address,user_id: widget.user.user_id);
               update(user).then((value){
                 if(hasError){
                   CoolAlert.show(context: context, type: CoolAlertType.error,
                     title: "Error",
                     text: "An issue occurred during the update process.",
                   );
                   print(errorDescr);
                 }else{
                   LocalStorage().updateNameKey(username).then((value){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Has Been Updated....")));
                    if( widget.onLoad!=null)
                       widget.onLoad!();
                     Navigator.pop(context);
                   });

                 }
               });

             },widget: Center(child: cText(text: "Edit",textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))),
           ),

          
      

       


         
         
        ],
      ),
    );
  }

}