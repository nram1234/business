import 'package:flutter/material.dart';
import 'package:business/Validation//ValidationData.dart';
class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> with ValidationData{
  final formkey = GlobalKey<FormState>();

  String email;
  String password;
  String password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      validator: vEmail,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (v) {
                        email = v;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          prefixIcon: Icon(Icons.alternate_email),
                          hintText: "you@example.com",
                          labelText: "Email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      obscureText: true,
                      validator: vPassword,
                      onSaved: (v) {
                        password = v;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "1234",
                          labelText: "Password"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      obscureText: true,
                      validator: vPassword,
                      onSaved: (v) {
                        password2 = v;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "1234",
                          labelText: "Password"),
                    ),
                  ),
                  RaisedButton(
                      padding: EdgeInsets.all(8),
                      child: Text('Sign up'),
                      onPressed: () async {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          //se you you ahve this eamil befor
                          if (password == password2) {

                          } else {
                            
                          }
                        }
                      }),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          " have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('SignInPage');
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.orange[200],
                                fontSize: 19),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}
