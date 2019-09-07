import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LayoutEditProfileNew extends StatefulWidget {
  @override
  _LayoutEditProfileNewState createState() => _LayoutEditProfileNewState();
}

class _LayoutEditProfileNewState extends State<LayoutEditProfileNew> {
  String string1, string2, string3, string4, string5, string6, string7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(inAsyncCall: false,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string1 = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string2 = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ) ,
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string3 = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string4= v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string5 = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string6 = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                onChanged: (v) {
                  string7 = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),RaisedButton(onPressed: (){
              print('$string1 , $string2, $string3, $string4, $string5, $string6, $string7');
            })],
        ),
      ),
    );
  }
}
