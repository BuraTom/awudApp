import 'dart:convert';
import 'package:awud_application/API/GoogleSignInApi.dart';
import 'package:awud_application/pages/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'constants.dart';
import 'package:http/http.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
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
  final formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  TextEditingController emailorphonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void login(String email , password) async {
    print(email);
    print(password);

    try{
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : email,
            'password' : password
          }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => navBar(),));
      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo){
    return GestureDetector(
      onTap: () => signIn(),
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   // Text emptyPass = Text("Password field can't be empty", style: TextStyle(fontSize: 5));
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
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      // _buildEmailTF(),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number or Email Address',
                                  style: kLabelStyle,
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextFormField(
                                    controller: emailorphonenumberController,
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
                                    validator: (value){
                                      if(value!.isNotEmpty){
                                        if(isNumeric(value)){
                                          if(!RegExp(r'^[+][0-9]{12,13}$').hasMatch(value)){
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
                                    validator: (value){
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
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30,),
                                        GestureDetector(
                                          onTap: (){

                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: kLabelStyle,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () => {
                                      if(formKey.currentState!.validate()){
                                        login(emailorphonenumberController.text.toString(), passwordController.text.toString())
                                      }
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      'LOGIN',
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
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '- OR -',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Text(
                                        'Sign in with',
                                        style: kLabelStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _buildSocialBtn(
                                            () => {

                                            },
                                        AssetImage(
                                          'assets/images/Google-Icon-PNG-768x768.jpg',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => registration()))
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Don\'t have an Account? ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Sign Up',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
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

  Future signIn() async{
    final user = await GoogleSignInApi.login();
    // you can pass user information using user variable above to navbar

    if(user == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign in  Failed')));
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => navBar()));
    }
  }

}
