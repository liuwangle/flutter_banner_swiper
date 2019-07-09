import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';



class Myexample extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyexampleState();
  }

}
class _MyexampleState extends State<Myexample>{
  @override
  void initState() {
    bannerList.add("http:\/\/minimg.hexun.com\/i4.hexunimg.cn\/mobile_show\/image\/20190701\/20190701121331_376_621x310.jpg");
    bannerList.add("http:\/\/minimg.hexun.com\/i7.hexun.com\/2015-11-16\/180596378_c324x234.jpg");
    bannerList.add("http:\/\/minimg.hexun.com\/i6.hexun.com\/2014-11-19\/170564509_c324x234.jpg");
    bannerList.add("http:\/\/minimg.hexun.com\/i7.hexun.com\/2014-09-02\/168105362_c324x234.jpg");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return getList();
  }

  List<String> bannerList=new List();
  Widget getList() {
    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 108,
      width: 54,
      //轮播图数目 必传
      length: 4,
      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child: Image.network(
              bannerList[index % bannerList.length],
              fit: BoxFit.cover,
            ),
            onTap: () {
              //点击后todo
            });
      },
    );
  }

}