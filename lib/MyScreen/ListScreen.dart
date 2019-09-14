import 'dart:core';

import 'package:business/DataType/DataType.dart';
import 'package:business/SpecialWidget/NewExpansionTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../app_Localizations.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> listna;
  bool _saving = false;
  bool _firaststart = true;
  Firestore _firestore=     Firestore.instance;
  List<String> catogerylist = [
    'Building',
    'Home',
    'Personal',
    'Animals',
    'Car',
    'Shops',
    'Restaurants'
  ];

  String catogery = 'Building';

  @override
  Widget build(BuildContext context) {
    listna = [
      AppLocalizations.of(context).translate('Building'),
      AppLocalizations.of(context).translate('Home'),
      AppLocalizations.of(context).translate('Personal'),
      AppLocalizations.of(context).translate('Animals'),
      AppLocalizations.of(context).translate('Car'),
      AppLocalizations.of(context).translate('Shops'),
      AppLocalizations.of(context).translate('Restaurants')
    ];
    return Column(
      children: <Widget>[
        Container(
          height: 130,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listna.length,
              itemBuilder: (context, pos) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                          onTap: () async {
                            _saving = true;
                            catogery = catogerylist[pos];

                            _firaststart = false;
                            setState(() {});

                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).accentColor,
                          )),
                      Text(listna[pos],textAlign: TextAlign.center,softWrap: true,style: TextStyle(fontSize: 18,color: Colors.black),)
                    ],
                  ),
                );
              }),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream:
            _firestore.collection('users')
                .document('proflie')
                .collection('user')
                .where('category', isEqualTo: catogery)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data==null) {
                return Center(
                  child: Text(
                    "no data to show",
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (snapshot.data.documents.isEmpty) {
                return Center(
                  child: Text(
                    "no data to show",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, i) {
                      DataTypeG _data =
                          DataTypeG.fromjson(snapshot.data.documents[i]);

                      return NewExpansionTile(context, _data);
                    });
              }
            },
          ),
        )
      ],
    );
  }

//  void showw(context){showDialog(
//    context: context,
//    builder: (BuildContext context) => CustomDialog(
//        title:
//        "Success",
//        description:
//
//        des,
//        buttonText:
//        'close',
//        tagg: 'commt'),
//  );}
//  String des='The application is built using Ruby on Rails, Vue Js, postgres, redis, elasticsearch.  You will be expected to set up the application withassistance from our development team and complete the required specificiations.assistance from our development team and complete the required specificiations.assistance from our development team and complete the required specificiations.assistance from our development team and complete the required specificiations.assistance from our development team and complete the required specificiations.'
//      'assistance from our development team and complete the required specificiations.assistance from our development team and complete the required specificiations. assistance from our development team and complete the required specificiations.';
//

//  )

//  Future<List<String>> myTypedFuture(String string) async {
//    List<String> data = [];
//    await Future.delayed(Duration(seconds: 5));
//    for (int i = 0; i < 100; i++) {
//      data.add(i.toString() + string);
//    }
//    damydata.clear();
//    damydata = data;
//    _saving = false;
//    return data;
//  }

  void getdatafromweb() async {
    await Firestore.instance
        .collection('users')
        .document('proflie')
        .collection('user')
        .where('category', isEqualTo: 'Car')
        .snapshots()
        .forEach((v) {
      for (var mydata in v.documents) {
        print(mydata.data.values);
      }
    }).whenComplete(() {
      _saving = false;
      _firaststart = false;
    });
  }
}
