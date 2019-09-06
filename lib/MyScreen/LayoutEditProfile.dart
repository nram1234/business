import 'dart:io';
import 'package:business/Validation/ValidationData.dart';
import 'package:business/app_Localizations.dart';
import 'package:business/utilitie/Userdata.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class LayoutEditProfile extends StatefulWidget {
  @override
  _LayoutEditProfileState createState() => _LayoutEditProfileState();
}

final formkey = GlobalKey<FormState>();

class _LayoutEditProfileState extends State<LayoutEditProfile>
    with ValidationData {
  File _image1, _image2, _image3, _image4;
  String usernamestring, userphonestring, useraddres, Describe;
  //controll scroll
  final FixedExtentScrollController scrollController =
  FixedExtentScrollController(initialItem: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: formkey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:   TextFormField(
                    initialValue: Userdata.username,
                    onSaved: (v) {
                      Userdata.username = v;
                    },
                    validator: username,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).translate('first_name')//'Your Name',
                        ,prefixIcon: Icon(Icons.person),
                        border:OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))) ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: Userdata.userphone,
                    onSaved: (v) {
                      Userdata.userphone = v;
                    },
                    validator: userphone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).translate('mobile'),
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoPickerWheelScroll()
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: Userdata.useraddres,
                    onSaved: (v) {
                      Userdata.useraddres = v;
                    },
                    validator: checkdata,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).translate('Address'),
                        prefixIcon: Icon(Icons.place),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (v) {
                      Userdata.Describe = v;
                    },
                    validator: checkdata,
                    autocorrect: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    initialValue: Userdata.Describe,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText:AppLocalizations.of(context).translate('description'),
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
                      child: _image1 == null
                          ? Image.asset(
                        'assets/images/add.png',
                        fit: BoxFit.cover,
                      )
                          : Image.file(_image1),
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
                )
              ,  CupertinoButton( child: Text(AppLocalizations.of(context).translate('save'),style: TextStyle(fontSize: 20),),onPressed: (){},)   ],
            )),
      ),
    );
  }

  //Image Picker
  Future getImage(int i) async {
    save();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      switch (i) {
        case 1:
          _image1 = image;
          break;

        case 2:
          _image2 = image;
          break;

        case 3:
          _image3 = image;
          break;

        case 4:
          _image4 = image;
          break;
      }
    });
  }

  void save() {
    //  if (formkey.currentState.validate()) {
    formkey.currentState.save();
    //se you you ahve this eamil befor


    // }
  }

  Widget CupertinoPickerWheelScroll(){
    return Container(height: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: CupertinoPicker( scrollController: scrollController, looping: true,backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          itemExtent: 50,
          onSelectedItemChanged: (item) {
            print('itemselected'+item.toString());
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.ac_unit),Text(AppLocalizations.of(context).translate('Restaurants')),Image.asset("images/gmailogo.jpg",fit: BoxFit.fitHeight,)],),
                height: 100,
              ),
            ), Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.zoom_out_map),Text(AppLocalizations.of(context).translate('Personal'))],),
                height: 100,
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.youtube_searched_for),Text(AppLocalizations.of(context).translate('Animals'))],),
                height: 100,
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.wc),Text(AppLocalizations.of(context).translate('Car'))],),
                height: 100,
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.wb_iridescent),Text(AppLocalizations.of(context).translate('Shops'))],),
                height: 100,
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.volume_off),Text(AppLocalizations.of(context).translate('Home'))],),
                height: 100,
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Row(children: <Widget>[Icon(Icons.view_module),Text(AppLocalizations.of(context).translate('Building'))],),
                height: 100,
              ),
            ) ]),
    );
  }



}
