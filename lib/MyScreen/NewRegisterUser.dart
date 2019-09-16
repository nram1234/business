import 'package:business/SignInPageWidget/CustomShapeClipper.dart';
import 'package:business/SignInPageWidget/CustomTextField.dart';
import 'package:business/SignInPageWidget/ResponsiveWidget.dart';
import 'package:business/Validation/ValidationData.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';



import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


class NewRegisterUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewRegister (),
    );
  }
}

class NewRegister  extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<NewRegister> with ValidationData {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  String password2;

  FirebaseUser _currentUser;
  bool is_register_user = false;

  StreamSubscription<FirebaseUser> _listener;


  @override
  void initState() {
    _checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),

              SizedBox(height: _height / 12),
              button(),
              signUpTextRow(),
              Container(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large ? _height / 4 : (_medium
                  ? _height / 3.75
                  : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amberAccent[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large ? _height / 4.5 : (_medium
                  ? _height / 4.25
                  : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amberAccent[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large ? _height / 30 : (_medium ? _height / 25 : _height /
                  20)),
          child: Image.asset(
            'images/login.png',
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Signup",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField2(),
            SizedBox(height: _height / 40.0),
            Container(
              height: 100,
              child:  SignInScreen(showBar: false,
                avoidBottomInset: false,
                bottomPadding: 0,
                horizontalPadding: 0,providers: [ProvidersTypes.google] ,  twitterConsumerSecret: '',
                twitterConsumerKey: '',),
            ), Container(
              height: 100,
              child: SignInScreen(showBar: false,
                avoidBottomInset: false,
                bottomPadding: 0,
                horizontalPadding: 0,providers: [ProvidersTypes.facebook] ,  twitterConsumerSecret: '',
                twitterConsumerKey: '',),
            ) ,

           ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: "Email ID",
      funvalidator: vEmail,
        onSavedd: (v) {
      email = v;
    } ,
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(

      textEditingController: passwordController,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
      funvalidator: vPassword,

        onSavedd: (v) {
          password = v;
        }
    );
  }
  Widget passwordTextFormField2() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordController2,

      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
      funvalidator: vPassword,
        onSavedd: (v) {
          password2 = v;
        }
    );
  }


  Widget button() {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        if (_key.currentState.validate()) {
          _key.currentState.save();
          //se you you ahve this eamil befor
          if (password == password2) {
            _auth.createUserWithEmailAndPassword(email: email, password: password).then((v){
              Navigator.of(context).popAndPushNamed('MyHomePage');
            }).catchError((e){
              // Handle Errors here.
              var errorCode = e.code;
              var errorMessage = e.message;
              // ...
              print(errorMessage);
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text(errorMessage)));
            });
          } else {
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text("Password does not match")));
          }
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.amberAccent[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN UP',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "have an account?",
            style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('SignInPage');
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.amberAccent[200],
                  fontSize: _large ? 20 : (_medium ? 18 : 16)),
            ),
          )
        ],
      ),
    );
  }
  void _checkCurrentUser() async {
    _currentUser = await _auth.currentUser();
    if(_currentUser == null){}
    _currentUser?.getIdToken(refresh: true);
    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      if(user == null){}else{
        Navigator.of(context).pushReplacementNamed('MyHomePage');
      }

      _currentUser = user;

    });
  }

}