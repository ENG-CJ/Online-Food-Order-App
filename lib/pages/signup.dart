import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/modals/user.dart';
import 'package:online_food_order_app/util/button.dart';
import 'package:online_food_order_app/validations.dart';

import '../const/url.dart';
import '../widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidden = true;
  var email = "";
  var password = "";
  var name = "";
  var address = "";
  int mobile = 0;

  bool hasError = false;
  bool registering = false;
  String errorDescr = "";

  var dio = Dio();
  bool hasData = false;

  Future<bool> checkExistance(email, mobile) async {
    setState(() {
      registering = true;
    });

    try {
      Response response = await dio
          .post("$URL/users/exists", data: {"email": email, "mobile": mobile});
     await checkResponse(response);
    } catch (e) {
      setState(() {
        hasData = false;
        hasError = true;
        errorDescr = e.toString();
        registering = false;
      });
    }
    setState(() {
      registering = false;
    });
    return hasData;
  }

  Future<void> create(User user) async {
    setState(() {
      registering = true;
    });

    try {
      Response response =
          await dio.post("$URL/customers/", data: user.toJson());
      if (response.data['status']) {
        print(response.data);
        setState(() {
          hasError = false;
          registering=false;
        });
      } else {
        setState(() {
          hasError = true;
          registering = false;
          errorDescr = response.data['description'];
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorDescr = e.toString();
        registering = false;
      });
    }
    setState(() {
      registering = false;
    });
  }

  Future<void> checkResponse(Response response) async {
    if (response.data['status']) {
      if (response.data['data'].length > 0) {
        hasData=true;
      } else {
        hasData=false;
      }
      hasError = false;
    } else {
        hasError = true;
        errorDescr = response.data['description'];
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: registering,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //this is the circle and the picture in the of the page
              Container(
                width: 375,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(290.0),
                    bottomRight: Radius.circular(290.0),
                  ),
                  color: colors['primary']!.withOpacity(0.4),
                ),
                child: Center(
                  child: Image.asset(
                    'asset/hum-star.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 20),
              //this is the text of the sign up and ragister text
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Poppins Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 3),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Welcome! Register here',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomField(
                  onTextChange: (value) {
                    name = value;
                  },
                  fielTitleTxt: "FullName",
                  hintText: "Hilal Fast Food...",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomField(
                  onTextChange: (value) {
                    email = value;
                  },
                  fielTitleTxt: "Email",
                  hintText: "Hilal@customer.com",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomField(
                  inputType: TextInputType.number,
                  onTextChange: (value) {
                    mobile = int.parse(value);
                  },
                  fielTitleTxt: "Mobile",
                  hintText: "61xxxxxxx",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomField(
                  onTextChange: (value) {
                    address = value;
                  },
                  fielTitleTxt: "Address",
                  hintText: "Hodan.",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomField(
                  onTextChange: (value) {
                    password = value;
                  },
                  isHidden: hidden,
                  fielTitleTxt: "Password",
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
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text.rich(TextSpan(
                    text: "Already Registered! ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: "Login",
                          style: TextStyle(fontFamily: "Poppins Bold")),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CButton(
                  onClick: () {
                    if(name=="" || email=="" || mobile==0 || password=="" || address=="")
                      {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Error",
                            text: "All Fields Are required");
                        return;
                      }
                    if(!Validator().mobileLen(mobile.toString()))
                    {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          title: "Error",
                          text: "Mobile must be 9 digits or 10 digits");
                      return;
                    }
                    checkExistance(email, mobile).then((value) {

                      if (hasError) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Something Went Wrong!",
                            text: errorDescr);
                        return;
                      }

                      if (value) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Exist!",
                            text:
                                "User With This Email Or Mobile Number Already Exists!");
                        return;
                      }
                      if(!Validator().isEmailValid(email)){
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Email Format",
                            text: "Incorrect Email Format use (example@gmail.com)");
                        return;
                      }
                      if(!Validator().containsOnlyLettersAndSpaces(name)){
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Name Format",
                            text: "FullName Must contain only letters and characters");
                        return;
                      }
                      if(!Validator().isFullNameValid(name)){
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "Name Length",
                            text: "Please Provide Your FullName in order to make valid order");
                        return;
                      }

                      var user = User(
                          username: name,
                          email: email,
                          password: password,
                          mobile: mobile,
                          address: address,
                          account_status: "active");
                      create(user).then((value) {
                        if(hasError){
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: "Error Occurred!",
                              text: errorDescr);
                          return;
                        }
                        Navigator.pop(context);

                      });
                    });
                  },
                  widget: Center(
                      child: Text(
                    'Signup',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins Bold",
                        color: Colors.white),
                  )),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
