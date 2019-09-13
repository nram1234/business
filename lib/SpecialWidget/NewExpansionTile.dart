import 'package:business/DataType/DataType.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

Widget NewExpansionTile(context, data ) {

  DataTypeG alldata=data;
String oo="Article Generator is an automatic online tool developed to help those who want to create fresh content for any purpose, whether you need content for your website, SEO , blog, school or college Article Generator can do that for you in few seconds, without any effort.Article Generator is one of the best article writing tool online as it can rewrite unique content for your website, blog or college, unique articles can increase your website ranking in search engines and can get more traffic to your website.Just scroll below, add the keyword on the topic you want to generate articles and click generate articles to get fresh articles.Article Generator is an automatic online tool developed to help those who want to create fresh content for any purpose, whether you need content for your website, SEO , blog, school or college Article Generator can do that for you in few seconds, without any effort.Article Generator is one of the best article writing tool online as it can rewrite unique content for your website, blog or college, unique articles can increase your website ranking in search engines and can get more traffic to your website.Just scroll below, add the keyword on the topic you want to generate articles and click generate articles to get fresh articles.Article Generator is an automatic online tool developed to help those who want to create fresh content for any purpose, whether you need content for your website, SEO , blog, school or college Article Generator can do that for you in few seconds, without any effort.Article Generator is one of the best article writing tool online as it can rewrite unique content for your website, blog or college, unique articles can increase your website ranking in search engines and can get more traffic to your website.Just scroll below, add the keyword on the topic you want to generate articles and click generate articles to get fresh articles.";
  return Card(
      elevation: 7,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Column(

        children: <Widget>[
          Container(

                  width: 150,//child:Image.network('https://image.freepik.com/free-vector/polaroid-style-frames-collection_23-2147509767.jpg',fit: BoxFit.fill,),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),

                ),

          ExpansionTile(
            title: Text('More data'),
            children: <Widget>[//Image.network('https://image.freepik.com/free-vector/polaroid-style-frames-collection_23-2147509767.jpg',fit: BoxFit.fill,),Image.network('https://firebasestorage.googleapis.com/v0/b/lost-84bb0.appspot.com/o/pic%2F2019-08-20T18%3A03%3A22.6401451989-11-09T00%3A00%3A00.000Z3590?alt=media&token=30cd1c2d-5c9a-4d14-9224-33c2816e5f7c',fit: BoxFit.fill,),Image.network('https://firebasestorage.googleapis.com/v0/b/lost-84bb0.appspot.com/o/pic%2F2019-08-20T18%3A03%3A22.6401451989-11-09T00%3A00%3A00.000Z3590?alt=media&token=30cd1c2d-5c9a-4d14-9224-33c2816e5f7c',fit: BoxFit.fill,),Image.network('https://firebasestorage.googleapis.com/v0/b/lost-84bb0.appspot.com/o/pic%2F2019-08-20T18%3A03%3A22.6401451989-11-09T00%3A00%3A00.000Z3590?alt=media&token=30cd1c2d-5c9a-4d14-9224-33c2816e5f7c',fit: BoxFit.fill,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(alldata.name),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(alldata.Address),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () => UrlLauncher.launch("tel://01112874607"),
                    child: Text(alldata.description)),
              )
            ],
          )
        ],
      ));
}
