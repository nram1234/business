import 'package:business/SpecialWidget/NewExpansionTile.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ListScreen extends StatefulWidget {
//  List<String>data;
//
//  ListScreen(this.data);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String>listna=[ 'Abbott',
    'wqwqwq',
    'reer',
    'tytytg',
    'jkjkj',
    'opopoo',
    'fdgdfgdfgdf',
    'mnbmbmb',
    'zazazaz',
    'xssxsxs',
    'fvfvfvf',
    'bgghgbghbg',
    'kmkmkmkm',
    'l..ll.',
    'bmbnmbnmbnm',
    '1111111111',
    'xcvxcvxvxcvx',
    'opopopop',
    'iuiuiyuyuyu',
    '898797978977',
    '54654654654',
    '2ewecvhcvvbnvbnvb',
    'Atkinson'];
  bool _saving = false;
  List<String>damydata=[];
  @override
  Widget build(BuildContext context) {
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
                  Text("joww uvfdhj")
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
