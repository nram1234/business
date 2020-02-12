import 'dart:async';

import 'package:business/app_Localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'MyScreen/LayoutEditProfile.dart';
import 'MyScreen/ListScreen.dart';
import 'MyScreen/NewRegisterUser.dart';
import 'MyScreen/RegisterUser.dart';
import 'MyScreen/SignInPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

// newwwwwwwwwwwwww


      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('en'), Locale('ar')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home:Center(child: Text(   'uuuu'),)// MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'MyHomePage',
      routes: {
        'MyHomePage': (context) => MyHomePage(),
        'SignInPage': (context) => SignInPage(),
        //   'RegisterUser': (context) => RegisterUser(),
        'NewRegisterUser': (context) => NewRegisterUser(),
      },
//  builder: (BuildContext context, Widget child){
//
//
//    return Padding(padding: EdgeInsets.only(bottom:55),child: child,);
//  },


    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum widgetpage { Home, Profile, Add_Me }

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin<MyHomePage> {

  //------------------------------------------------------------


//
//  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    keywords: <String>['Mobile','People','Car','Motorcycle','Documents','Animal','Camera','Wallet','Laptop','work'
//      , 'job','freelancer','Building and construction','Services','hand-made','Handcrafts','Clothes','shoes','Restaurants','Food','Cleaning','Shopping','trade'
//    ],
//
//  );
//  BannerAd myBanner = BannerAd(
//    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//    // https://developers.google.com/admob/android/test-ads
//    // https://developers.google.com/admob/ios/test-ads
//    adUnitId: 'ca-app-pub-7535075522299407/9296395199',
//    size: AdSize.banner,
//    //targetingInfo: targetingInfo,
//    listener: (MobileAdEvent event) {
//      print("BannerAd event is $event");
//
//      print("MobileAdEvent.impression");
//    },
//  );
//







  //=================================================================


















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
//    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-7535075522299407~4357276740');
//    myBanner..load()..show(  anchorOffset: 0.0,anchorType: AnchorType.bottom);
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
    super.dispose();
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
        body: FutureBuilder(
          future: _playAnimation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return SafeArea(
              top: true,
              child: getCustmBadg(),
            );
          },
        ),
        bottomNavigationBar:
            is_register_user ? register_user() : not_register_user());
  }

  Widget register_user() {
    return FancyBottomNavigation(
      tabs: [
        TabData(iconData: Icons.home, title: "Home"),
        TabData(iconData: Icons.person, title: "Profile")
      ],
      onTabChangedListener: (position) {
        switch (position) {
          case 0:
            setState(() {
              selectpage = widgetpage.Home;
            });
            break;

          case 1:
            setState(() {
              selectpage = widgetpage.Profile;
            });
            break;
        }
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
              selectpage = widgetpage.Home;
            });
            break;
//            case 1:
//              setState(() {
//                selectpage = widgetpage.Favorite;
//              });
//              break;
          case 1:
            setState(() {
              selectpage = widgetpage.Add_Me;
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
            child: Container(child: ListScreen()) // CategoryList(),

            );
      case widgetpage.Profile:
        return FadeTransition(
            opacity: _animation, child: LayoutEditProfile() // ProfileLayout(),
            );
        break;
      case widgetpage.Add_Me:
        return FadeTransition(
          opacity: _animation,
          child: NewRegisterUser(),
        );
        break;
    }
    return Container(
      color: Colors.blue,
    ); //CategoryList();
  }
}
