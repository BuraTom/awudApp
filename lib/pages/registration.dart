import 'dart:convert';
import 'package:awud_application/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:http/http.dart';

import 'otp.dart';


class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  final formKey = GlobalKey<FormState>();
  TextEditingController emailorphonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    void register(String email ,String password,String username) async {
      try{
        Response response = await post(Uri.parse('http://192.168.43.196:5000/user/signup/'),
            body: {
              'name': username,
              'email' : email,
              'password' : password
            }
        );
        if(response.statusCode == 200){
          print('Success');
          var data = jsonDecode(response.body.toString());
          if(isNumeric(email)){
            print(email);
            print(email.runtimeType);
            try{
              Response response = await post(Uri.parse('http://192.168.43.196:5000/phonenumber/'),
                  body: {
                    "phone": email
                  }
              );
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyPhone(phone:email.toString())));
            }catch(e){
              print(e.toString());
              final snackBar = SnackBar(
                content: const Text('Error sending user code'),
                action: SnackBarAction(
                  label: 'Error',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }else{
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyPhone()));
          }
        }else {
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 50),
          );
        }
      }catch(e){
        print(e.toString());
        final snackBar = SnackBar(
          content: const Text('Error registering user'),
          action: SnackBarAction(
            label: 'Error',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(248, 135, 88, 1),
                      Color.fromRGBO(248, 135, 88, 1),
                      Color.fromRGBO(248, 135, 88, 1),
                      Color.fromRGBO(248, 135, 88, 1),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Registration',
                        style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      // _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username',
                                  style: kLabelStyle,
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextFormField(
                                    controller: usernameController,
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter your username',
                                      hintStyle: kHintTextStyle,
                                    ),
                                    validator: (value) => value!.isEmpty ? 'Username filed can\'t be empty' : null,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  'Phone Number or Email address',
                                  style: kLabelStyle,
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextFormField(
                                    controller: emailorphonenumberController,
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter your Phone Number or Email Address',
                                      hintStyle: kHintTextStyle,
                                    ),
                                    validator: (value) {
                                      if(value!.isNotEmpty){
                                        if(isNumeric(value)){
                                          if(!RegExp(r'^[0-9]{12,13}$').hasMatch(value)){
                                            return "Enter correct phone number";
                                          }
                                        }else{
                                          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                            return "Enter correct email address";
                                          }
                                        }
                                      }
                                      else{
                                        return "Phone Number or Email address field can't be empty";
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  'Password',
                                  style: kLabelStyle,
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextFormField(
                                    controller: passwordController,
                                    autofocus: false,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter your Password',
                                      hintStyle: kHintTextStyle,
                                    ),
                                    validator: (value) {
                                      if(value!.isNotEmpty){
                                        if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                                          return "Password should contain one uppercase, one lowercase, at least one digit, at least one character and password length must be greater than 8";
                                        }
                                      }else{
                                        return "Password field can't be empty";
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 50.0),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () {
                                      if(formKey.currentState!.validate()){
                                        register(emailorphonenumberController.text.toString(), passwordController.text.toString(), usernameController.text.toString());
                                      }
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      'REGISTER',
                                      style: TextStyle(
                                        color: Color(0xFF527DAA),
                                        letterSpacing: 1.5,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
