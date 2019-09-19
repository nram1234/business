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

                  height: 150, child:Image.network(alldata.image1,fit: BoxFit.cover,),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),

                ),

          ExpansionTile(
            title: Text('More data'),
            children: <Widget>[ Image.network( alldata.image1,fit: BoxFit.fill,) ,Image.network( alldata.image2,fit: BoxFit.fill,) ,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(alldata.name),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(alldata.Address),
              ),Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(alldata.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () => UrlLauncher.launch("tel://${alldata.mobile}"),
                    child: Text(alldata.mobile)),
              )
            ],
          )
        ],
      ));
}
