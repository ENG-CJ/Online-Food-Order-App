import 'package:alert_dialog/alert_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/pages/home.dart';
import 'package:online_food_order_app/pages/signup.dart';
import 'package:online_food_order_app/storage/local_storage.dart';
import 'package:online_food_order_app/util/button.dart';
import 'package:online_food_order_app/validations.dart';
import 'package:online_food_order_app/widgets/text_field.dart';

import '../../const/texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidden = false;
  var email = "";
  var validationEmail = "";
  var password = "";
  var newPassword = "";
  var confirmPassword = "";
  bool hasError = false;
  bool authenticating = false;
  bool logging = false;
  String errorDescr = "";

  var dio = Dio();
  Future<bool> authenticate() async {
    print("getting");
    setState(() {
      logging = true;
    });
    bool hasData = false;
    try {
      print("getting 1");
      await Future.delayed(Duration(seconds: 3));
      print("getting2");
      Response response = await dio.get("$URL/customers/$email/$password");
      if (response.data['status']) {
        if (response.data['data'].length > 0) {

          LocalStorage().createLocalData({
            "name": response.data['data'][0]['fullName'],
            "id": response.data['data'][0]['cust_id'],
            "pass": response.data['data'][0]['password'],
          });
          setState(() {
            hasError = false;
            logging = false;
            hasData = true;
          });

          return hasData;
        } else {
          print("getting4");
          setState(() {
            hasData = false;
            logging = false;
            hasError = false;
          });
        }
        return hasData;
      }
      setState(() {
        hasError = true;
        logging = false;
        errorDescr = response.data['description'];
      });
    } catch (e) {
      print("getting5");
      setState(() {
        hasData = false;
        hasError = true;
        logging = false;
        errorDescr=e.toString();
      });
    }
    setState(() {
      logging = false;
    });
    return hasData;
  }

  Future<bool> validateEmail() async {
    setState(() {
      authenticating = true;
    });
    bool hasData = false;
    try {
      Response response = await dio.post("$URL/customers/validateEmail",data: {"email": validationEmail});
      if (response.data['status']) {
        if (response.data['data'].length > 0) {
          setState(() {
            hasError = false;
            hasData = true;
          });
          print(">0");
          return hasData;
        } else {
          print("else");
          setState(() {
            hasData = false;
            hasError = false;

          });
        }
        return hasData;
      }
      print("false");
      setState(() {
        hasError = true;
        errorDescr = response.data['description'];
      });
    } catch (e) {
      print("catcj");
      setState(() {
        hasData = false;
        hasError = true;
        errorDescr=e.toString();
        authenticating = false;
      });
    }
    setState(() {
      authenticating = false;
    });
    return hasData;
  }

  Future<void> updatePassword() async {
    try {
      Response response = await dio.post("$URL/customers/updatePass",data: {"pass": newPassword, "email": validationEmail});
      if (response.data['status']) {
        hasError = false;
      } else {
        hasError = true;
        errorDescr=response.data['description'];
      }

      setState(() {});
    } catch (e) {
      hasError=true;
      errorDescr=e.toString();
      setState(() {});
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalStorage().clearLocalData().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: logging,
          child: SingleChildScrollView(
                child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 380,
              decoration: const BoxDecoration(
                  // shape: BoxShape.circle,
                  // color: Colors.blue,
                  ),
              child: Stack(
                children: [
                  Positioned(
                    top: -130,
                    right: 10,
                    // left: -60,
                    child: Container(
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(290)),
                        color: colors['primary']!.withOpacity(0.25),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: -20,
                    child: Image.asset(
                      'asset/burger.png',
                      width: 400,
                      height: 400,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loginTitle,
                    style: TextStyle(fontSize: 20, fontFamily: "Poppins Bold"),
                  ),
                  Text(
                    loginSubTitle,
                    style: TextStyle(fontSize: 15, fontFamily: "Poppins Light"),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomField(
                    onTextChange: (value) {
                      email = value;
                    },
                    fielTitleTxt: emailTitle,
                    hintText: emailPlaceholder,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomField(
                    onTextChange: (value) {
                      password = value;
                    },
                    isHidden: hidden,
                    fielTitleTxt: passwordTitle,
                    hintText: "your-password",
                    suffixIcon: hidden
                        ? InkWell(
                            onTap: () => setState(() {
                                  hidden = false;
                                }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FaIcon(FontAwesomeIcons.eye),
                            ))
                        : InkWell(
                            onTap: () => setState(() {
                                  hidden = true;
                                }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FaIcon(FontAwesomeIcons.eyeSlash),
                            )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        validationEmail='';
                      });
                      showModalBottomSheet(

                          context: context, builder: (_)=>Container(
                        height: 530,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text("To Change Your Password, Please Provide Your Email Account!",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins Bold",
                                color: colors['primary']
                              ),),
                              SizedBox(height: 20,),
                              CustomField(
                                  onTextChange: (value){
                                    validationEmail=value;
                                    setState(() {

                                    });
                                  },
                                  hintText: "example@gmail.com", fielTitleTxt: "Email"),
                              SizedBox(height: 8,),
                              CButton(
                                  onClick: (){
                                    if(validationEmail==""){
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "In Order To Change Your Password, "
                                                        " Provide Your Valid Email Address.",

                                                style: TextStyle(color: Colors.redAccent, fontFamily: "Poppins Bold"),),
                                                SizedBox(
                                                  height: 14,

                                                ),


                                                CButton(
                                                  onClick: () {
                                                   Navigator.pop(context);
                                                  },
                                                  widget: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          FaIcon(FontAwesomeIcons
                                                              .arrowLeft),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Return",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontFamily:
                                                                "Poppins Bold"),
                                                          ),
                                                        ],
                                                      )),
                                                  width: double.maxFinite,
                                                  radius: 16,
                                                )
                                              ],
                                            ),
                                          ));
                                      return;
                                    }
                                    if(!Validator().isEmailValid(validationEmail)){
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Incorrect Email Format, Please use this example : (yourmail@domain.sublevel",

                                                  style: TextStyle(color: Colors.redAccent, fontFamily: "Poppins Bold"),),
                                                SizedBox(
                                                  height: 14,

                                                ),


                                                CButton(
                                                  onClick: () {
                                                    Navigator.pop(context);
                                                  },
                                                  widget: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          FaIcon(FontAwesomeIcons
                                                              .arrowLeft),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Return",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontFamily:
                                                                "Poppins Bold"),
                                                          ),
                                                        ],
                                                      )),
                                                  width: double.maxFinite,
                                                  radius: 16,
                                                )
                                              ],
                                            ),
                                          ));

                                      return;
                                    }
                                    validateEmail().then((value) {
                                      if(hasError){
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    errorDescr,

                                                    style: TextStyle(color: Colors.redAccent, fontFamily: "Poppins Bold"),),
                                                  SizedBox(
                                                    height: 14,

                                                  ),


                                                  CButton(
                                                    onClick: () {
                                                      Navigator.pop(context);
                                                    },
                                                    widget: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            FaIcon(FontAwesomeIcons
                                                                .arrowLeft),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Return",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontFamily:
                                                                  "Poppins Bold"),
                                                            ),
                                                          ],
                                                        )),
                                                    width: double.maxFinite,
                                                    radius: 16,
                                                  )
                                                ],
                                              ),
                                            ));
                                        return;
                                      }
                                      if(!value){
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Provided Email $validationEmail Does not exist, Please Provide Valid Email",

                                                    style: TextStyle(color: Colors.redAccent, fontFamily: "Poppins Bold"),),
                                                  SizedBox(
                                                    height: 14,

                                                  ),


                                                  CButton(
                                                    onClick: () {
                                                      Navigator.pop(context);
                                                    },
                                                    widget: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            FaIcon(FontAwesomeIcons
                                                                .arrowLeft),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Return",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontFamily:
                                                                  "Poppins Bold"),
                                                            ),
                                                          ],
                                                        )),
                                                    width: double.maxFinite,
                                                    radius: 16,
                                                  )
                                                ],
                                              ),
                                            ));
                                        return;
                                      }
                                      Navigator.pop(context);
                                      showModalBottomSheet(context: context, builder: (_)=>_buildNewPasswordModalSheet(context));



                                    });
                                  },
                                  widget: Center(child: Text("Search",style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Poppins Bold"),),))
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Text.rich(TextSpan(
                        text: "Forgot Password?",
                        style: Theme.of(context).textTheme.bodyMedium,
                    ))
                  ),

                  TextButton(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => SignUpPage())),
                    child: Text.rich(TextSpan(
                        text: dontHaveAcc,
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: signUp,
                              style: TextStyle(fontFamily: "Poppins Bold")),
                        ])),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      height: 65,
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colors['primary'],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0))),
                        onPressed: () {
                          if (email == "" || password == "") {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: "Error",
                                text: "Email and Password is Required");
                            return;
                          }
                          if (!Validator().isEmailValid(email)) {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: "Error",
                                text: "Incorrect Email Format");
                            return;
                          }
                          authenticate().then((value) {
                            print("vaalue is $value");
                            if (hasError) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: "Error",
                                  text: errorDescr);
                              setState(() {
                                email= password="";
                              });
                              return;
                            }
                            if (!value) {

                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: "Error",
                                  text: "Incorrect Email or Password");
                              setState(() {
                                email= password="";
                              });
                              return;
                            }
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
                          });
                        },
                        child: Text(loginTitle,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: colors['body-color'])),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
                ),
              ),
        ));
  }

  Widget _buildNewPasswordModalSheet(BuildContext context) {
    return  Container(
      height: 580,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),

            CustomField(
                onTextChange: (value){
                  newPassword=value;
                  setState(() {

                  });
                },
                hintText: "xxxxxx", fielTitleTxt: "New Password"),
            SizedBox(height: 8,),
            CustomField(
                onTextChange: (value){
                  confirmPassword=value;
                  setState(() {

                  });
                },
                hintText: "confirm", fielTitleTxt: "Confirm Password"),
            SizedBox(height: 10,),
            CButton(
                onClick: (){
                  if(newPassword=="" || confirmPassword==""){
                    alert(context, title: Text("Error"), content: Text("All Fields Are required",
                      style: TextStyle(
                          color: Colors.red
                      ),));
                    return;
                  }
                  if(!Validator().passLength(newPassword)){
                   alert(context, title: Text("Error"), content: Text("Password Length Must be greater than 4 characters",
                   style: TextStyle(
                     color: Colors.red
                   ),));

                    return;
                  }
                  if(confirmPassword!=newPassword){
                    alert(context, title: Text("Error"), content: Text("Confirm Password Must be same as New Password",
                      style: TextStyle(
                          color: Colors.red
                      ),));

                    return;
                  }
                  updatePassword().then((value) {
                    if(hasError){
                      alert(context, title: Text("Error"), content: Text(errorDescr,
                        style: TextStyle(
                            color: Colors.red
                        ),));
                      return;
                    }
                    Navigator.pop(context);
                    alert(context, title: Text("Privacy"), content: Text("Your Security Code has been changed successfully..",
                      style: TextStyle(
                          fontFamily: "Poppins Bold"
                      ),));
                  });
                },
                widget: Center(child: Text("Search",style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Poppins Bold"),),))
          ],
        ),
      ),
    );

  }
}
