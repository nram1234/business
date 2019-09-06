import 'package:business/SpecialWidget/NewExpansionTile.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../app_Localizations.dart';
class ListScreen extends StatefulWidget {


  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String>listna;
  bool _saving = false;
  List<dynamic>damydata=[];
  @override
  Widget build(BuildContext context) {
    listna=[AppLocalizations.of(context).translate('Building'),AppLocalizations.of(context).translate('Home'),AppLocalizations.of(context).translate('Personal'),AppLocalizations.of(context).translate('Animals'),AppLocalizations.of(context).translate('Car'),AppLocalizations.of(context).translate('Shops'),AppLocalizations.of(context).translate('Restaurants')];
    return  Column(children: <Widget>[  Container(
      height: 130,
      child: ListView.builder(    
          scrollDirection: Axis.horizontal,
          itemCount: listna.length,    
          itemBuilder: (context, pos) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                      onTap: () async{
                        setState(() {
                          _saving = true;
                        });

                        await myTypedFuture(listna[pos]);
                        setState(() {

                        });
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepOrange,
                      )),
                  Text(listna[pos])
                ],
              ),
            );
          }),),Expanded(
            child: ModalProgressHUD(

                child:  ListView.builder(itemCount: damydata.length,itemBuilder: (context,pos){
      return  NewExpansionTile(context,damydata[pos]);

    }),

            inAsyncCall: _saving
            ),
          ) ],) ;
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


  Future<List<String>> myTypedFuture(String string) async {
    List<String> data = [];
    await Future.delayed(Duration(seconds: 5));
    for (int i = 0; i < 100; i++) {
      data.add(i.toString() + string);
    }
    damydata.clear();
    damydata=data;
    _saving = false;
    return data;
  }





}
