import 'dart:async';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;
  FirebaseUser _currentUser;
  bool is_register_user =false ;

  @override
  void initState() {
    super.initState();

      _checkCurrentUser();

  }

  @override
  void dispose() {
    _listener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if(_currentUser == null){
      is_register_user =false ;
      print('i get nooooooooooooouser');
    }else{

      is_register_user =true ;
      setState(() {

      });
      print('i get user');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: SignInScreen(
                  showBar: false,
                  avoidBottomInset: false,
                  bottomPadding: 0,
                  horizontalPadding: 0,
                  providers: [ProvidersTypes.google],
                  twitterConsumerSecret:'',twitterConsumerKey: '',),
              )
            ],
          ),
        ),
        bottomNavigationBar:
        is_register_user ? register_user() : not_register_user());
  }

  Widget register_user() {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: Icons.home, title: "Home"),
        TabData(iconData: Icons.favorite, title: "Favorite"),
        TabData(iconData: Icons.person, title: "Profile")
      ],
      onTabChangedListener: (position) {
        setState(() {
          switch (position) {
            case 0:
              setState(() {
                // selectpage = widgetpage.Home;
              });
              break;
            case 1:
              setState(() {
                //  selectpage = widgetpage.Favorite;
              });
              break;
            case 2:
              setState(() {
                // selectpage = widgetpage.Profile;
              });
              break;
          }
        });
      },
    );
  }

  Widget not_register_user() {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: Icons.home, title: "Home"),
        // TabData(iconData: Icons.favorite, title: "Favorite"),
        TabData(iconData: Icons.add_box, title: "Add Me")
      ],
      onTabChangedListener: (position) {
        switch (position) {
          case 0:
            setState(() {
              //   selectpage = widgetpage.Home;
            });
            break;
//            case 1:
//              setState(() {
//                selectpage = widgetpage.Favorite;
//              });
//              break;
          case 1:
            setState(() {
              // selectpage = widgetpage.Add_Me;
            });
            break;
        }
      },
    );
  }

  void _checkCurrentUser() async {
    _currentUser = await _auth.currentUser();
    _currentUser?.getIdToken(refresh: true);
    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;
      });
    });
  }
}
