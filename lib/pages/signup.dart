import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         //this is the circle and the picture in the of the page 
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(190.0),
                bottomRight: Radius.circular(190.0),
              ),
              color: Colors.green,
            ),
            child: Center(
              child: Image.asset(
                '././assets/img3.png',
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
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
          //this is all the text field in the page
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    fillColor: Colors.green.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.green.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Address',
                    fillColor: Colors.green.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                    fillColor: Colors.green.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.green.withOpacity(0.2),
                    filled: true,
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Already registered? Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          //this is the sign up buttom
          ElevatedButton(
            onPressed: () {},
            child: Text('Sign Up'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
