import 'dart:async';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'MyScreen/RegisterUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'MyHomePage',
      routes: {
        'MyHomePage': (context) => MyHomePage(),
        //'SignInPage':(context)=>SignInPage(),
        'RegisterUser': (context) => RegisterUser(),
        //'MyHomePage':(context)=>MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum widgetpage { Home, Favorite, Profile, Add_Me }

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin<MyHomePage> {
  AnimationController _controller;
  Animation _animation;

  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;
  FirebaseUser _currentUser;
  bool is_register_user = false;

  widgetpage selectpage = widgetpage.Home;

  @override
  void initState() {
    super.initState();

    _checkCurrentUser();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  //animation of page
  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _listener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      is_register_user = false;
    } else {
      is_register_user = true;
      setState(() {});
      print('i get user');
    }

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                child: ListView.builder(itemCount: 100, itemBuilder: (context,pos){
                  return ChoiceChip(backgroundColor: Colors.amber,label:Text('uuu') ,avatar: Icon(Icons.access_alarm,size: 100,),);
                }),
              ),
              Text(is_register_user ? _currentUser.email : 'not have user'),
              RaisedButton(onPressed: () {
                _auth.signOut();
              })
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

  Widget getCustmBadg() {
    switch (selectpage) {
      case widgetpage.Home:
        return FadeTransition(
          opacity: _animation,
          child: Container(
            child: CategoryList(),
          ),
        );
      case widgetpage.Favorite:
        return FadeTransition(
          opacity: _animation,
          child: Container(
            child: CardList(),
          ),
        );
      case widgetpage.Profile:
        return FadeTransition(
          opacity: _animation,
          child: ProfileLayout(),
        );
        break;
      case widgetpage.Add_Me:
        return FadeTransition(
          opacity: _animation,
          child: RegisterUser(),
        );
        break;
    }
    return CategoryList();
  }
}
