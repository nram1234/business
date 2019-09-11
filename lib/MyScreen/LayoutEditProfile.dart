import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:business/DataType/DataType.dart';
import 'package:business/Validation/ValidationData.dart';
import 'package:business/app_Localizations.dart';
import 'package:business/utilitie/Userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool _saving = false;

class LayoutEditProfile extends StatefulWidget {
  @override
  _LayoutEditProfileState createState() => _LayoutEditProfileState();
}

class _LayoutEditProfileState extends State<LayoutEditProfile>
    with ValidationData {
  File _image1, _image2, _image3, _image4;
  bool  img2=false,img3=false,img4=false;
  final formkey = GlobalKey<FormState>();
  List<File> listimage = [];
  String usernamestring,
      userphonestring,
      useraddres,
      Describe,
      piclink,
      category;
  //===================================================================
TextEditingController _usernameController=TextEditingController();
TextEditingController _userphonController=TextEditingController();
TextEditingController _useraddresController=TextEditingController();
TextEditingController _DescribeController=TextEditingController();

  //===================================================================

  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;
  FirebaseUser _currentUser;


  List<String> imagelinke = [' ',' ',' ',' '];

  final _firestore = Firestore.instance;

  List<String> categoryscroll = [
    'Restaurants',
    'Personal',
    'Animals',
    'Car',
    'Shops',
    'Home',
    'Building'
  ];

  @override
  void initState()  {

    CurrentUser();



  }

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(initialItem: 2);

  @override
  Widget build(BuildContext context) {
    _getuserdata();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ModalProgressHUD(
          inAsyncCall: _saving,
          child: Form(
              key: formkey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(controller: _usernameController,
                      onChanged: (v) {
                        Userdata.username = v;
                        usernamestring = v;
                      },
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .translate('first_name') //'Your Name',
                          ,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _userphonController,
                      onChanged: (v) {
                        Userdata.userphone = v;
                        userphonestring = v;
                      },

                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context).translate('mobile'),
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoPickerWheelScroll()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _useraddresController,
                      onChanged: (v) {
                        Userdata.useraddres = v;
                        useraddres = v;
                      },

                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context).translate('Address'),
                          prefixIcon: Icon(Icons.place),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _DescribeController,
                      onChanged: (v) {
                        Userdata.Describe = v;
                        Describe = v;
                      },
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,

                      decoration: InputDecoration(
                          isDense: true,
                          hintText: AppLocalizations.of(context)
                              .translate('description'),
                          prefixIcon: Icon(Icons.info),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onLongPress: () {
                        //pop mnue dlate pic
                      },
                      onTap: () {
                        getImage(1);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: _image1 == null
                              ? Image.asset(
                            'assets/images/add.png',
                            fit: BoxFit.fill,
                          )
                              : Image.file(_image1),
                        ),
                      ),
                    ),
                  ),
                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          getImage(2);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: _image2 == null
                              ? Image.asset(
                                  'assets/images/add.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.file(_image2),
                        ),
                      ),
                    ),

                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () {
                          //pop mnue dlate pic
                        },
                        onTap: () {
                          getImage(3);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: _image3 == null
                              ? Image.asset(
                                  'assets/images/add.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.file(_image3),
                        ),
                      ),
                    ),

                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () {
                          //pop mnue dlate pic
                        },
                        onTap: () {
                          getImage(4);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: _image4 == null
                              ? Image.asset(
                                  'assets/images/add.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.file(_image4),
                        ),
                      ),
                    ),

                  CupertinoButton(
                    child: Text(
                      AppLocalizations.of(context).translate('save'),
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      _saving = true;
                      setState(() {});
                      await save();
                    },
                  ),
                  CupertinoButton(
                    child: Text(
                      'get my data',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _getuserdata();






//
//
//                      StorageReference storageRef =
//                          FirebaseStorage.instance.ref();
//
//// Create a reference to the file to delete
//                      StorageReference desertRef =
//                          storageRef.child("images/desert.jpg");
////                  desertRef.delete().then((val){
////                    print( '99999999999' );
////                  }).catchError((){
////
////
////                    print('1111111111111111111111111111111111111111111111111111111111');
////                  });
//
//                      var desertRef2 = storageRef.getStorage().getReferenceFromUrl(
//                          'https://firebasestorage.googleapis.com/v0/b/business-fb699.appspot.com/o/images%2Fdesert.jpg?alt=media&token=7b1a2400-5061-4494-9674-8db18e3e6f27');
//                      desertRef2.then((v) {
//                        v.delete();
//                      });
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }

  //Image Picker
  Future getImage(int i) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      switch (i) {
        case 1:
          _image1 = image;
          if(_image1!=null){
            img2=true;
          }
          listimage.add(_image1);
          break;

        case 2:
          _image2 = image;
          if(_image2!=null){
            img3=true;
          }
          listimage.add(_image2);

          break;

        case 3:
          _image3 = image;
          if(_image3!=null){
            img4=true;
          }
          listimage.add(_image3);
          break;

        case 4:
          _image4 = image;
          listimage.add(_image4);
          break;
      }
    });
  }

  void save() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      for (int i = 0; i < listimage.length; i++) {
        if (listimage[i] != null) {
          await uploadpic(listimage[i]);
        }
      }

      DataTypeG dataType = DataTypeG(
          name: usernamestring,
          mobile: userphonestring,
          Address: useraddres,
          category: category,
          description: Describe,
          image1: imagelinke[0],
          image2: imagelinke[1],
          image3: imagelinke[2],
          image4: imagelinke[3],
          email: _currentUser.email);


//        _firestore.collection("profile") .document(category).collection(_currentUser.uid) .add(dataType.tojson()).whenComplete(() {
//        _saving = false;
//        Navigator.of(context).popAndPushNamed('MyHomePage');
//      });
      _firestore.collection('users').document("proflie").collection('user').document( _currentUser.uid ).setData(dataType.tojson()).whenComplete((){
        print("iam do");
        setState(() {
          _saving=false;
        });
      });


    }
  }

  Future uploadpic(imag) async {
    Random random = new Random();
    var now = new DateTime.now();
    var berlinWallFell = new DateTime.utc(1989, 11, 9);
    int index = random.nextInt(100000);
    String name = now.toIso8601String() +
        berlinWallFell.toIso8601String() +
        index.toString();

    final StorageReference storageReference =
        FirebaseStorage().ref().child('pic').child(name);

    final StorageUploadTask uploadTask = storageReference.putFile(imag);
    StorageTaskSnapshot taskSnapshot =
        await uploadTask.onComplete.catchError((e) {
      print(e);
    });
    piclink = await taskSnapshot.ref.getDownloadURL();
    imagelinke.add(piclink);
  }

  Future<StorageReference> getReferenceFromUrl(String fullUrl) async {
    StorageReference storageRef = FirebaseStorage.instance.ref();
    var desertRef2 = storageRef.getStorage().getReferenceFromUrl(fullUrl);
    desertRef2.then((v) {
      v.delete();
    });
  }

  Widget CupertinoPickerWheelScroll() {
    return Container(
      height: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: CupertinoPicker(
          scrollController: scrollController,
          looping: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          itemExtent: 50,
          onSelectedItemChanged: (item) {
            category = categoryscroll[item];
            print('itemselected' + item.toString());
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Text(AppLocalizations.of(context).translate('Restaurants')),
                    Image.asset(
                      "images/gmailogo.jpg",
                      fit: BoxFit.fitHeight,
                    )
                  ],
                ),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.zoom_out_map),
                    Text(AppLocalizations.of(context).translate('Personal'))
                  ],
                ),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.youtube_searched_for),
                    Text(AppLocalizations.of(context).translate('Animals'))
                  ],
                ),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.wc),
                    Text(AppLocalizations.of(context).translate('Car'))
                  ],
                ),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.wb_iridescent),
                    Text(AppLocalizations.of(context).translate('Shops'))
                  ],
                ),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.volume_off),
                    Text(AppLocalizations.of(context).translate('Home'))
                  ],
                ),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.view_module),
                    Text(AppLocalizations.of(context).translate('Building'))
                  ],
                ),
                height: 100,
              ),
            )
          ]),
    );
  }


  void  CurrentUser() async {
    _currentUser = await _auth.currentUser();

    _currentUser?.getIdToken(refresh: true);
    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;

      });
    });
  }


  _savedatalocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _currentUser.email);
    await prefs.setString('mobile', userphonestring);
    await prefs.setString('category',category);
    await prefs.setString('Describe', Describe);
    if(imagelinke[0]!=null){
      await prefs.setString('image0', imagelinke[0]);
    }

    if(imagelinke[1]!=null){ await prefs.setString('image1', imagelinke[1]);}

    if(imagelinke[2]!=null){ await prefs.setString('image2',imagelinke[2]);}

    if(imagelinke[3]!=null){   await prefs.setString('image3', imagelinke[3]);}



  }
  _getuserdata()async{
    if(_currentUser.uid!=null){
      _firestore.collection('users').document("proflie").collection('user').document( _currentUser.uid ).get().then((v){
        if(!v.data.isEmpty){
          DataTypeG data=DataTypeG.fromjson(v.data);
          _usernameController.text= data.name ??  AppLocalizations.of(context)
              .translate('first_name');
          _userphonController.text=data.mobile ??  AppLocalizations.of(context).translate('mobile');
          _useraddresController.text=data.Address ?? AppLocalizations.of(context).translate('Address');
          _DescribeController.text=data.Address ?? AppLocalizations.of(context)
              .translate('description');
          imagelinke[0]=data.image1;
          imagelinke[1]=data.image2;
          imagelinke[2]=data.image3;
          imagelinke[3]=data.image4;



        }



      });


    }
    setState(() {

    });
  }
  Widget imagefromweb(url){


    if(url!=null)
      {}
    return Container(height: 100,child: Image.network(url),);
  }
}
