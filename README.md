# flutter_banner_swiper

A refresh loadmore listview package.

## Getting Started
Installing
 ```dart
flutter_banner_swiper: ^0.7
```

Import
 ```dart
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
```

How To Use

 ```dart
     BannerSwiper(

           //width  和 height 是图片的高宽比  不用传具体的高宽   必传
           height: 108,
           width: 54,
           //轮播图数目 必传
           length: bannerList.length,

           //轮播的item  widget 必传
           getwidget: (index) {
             return new GestureDetector(
                 child:  Image.network(bannerList[index % bannerList.length].img,fit: BoxFit.cover,),
                 onTap: () {
                   //点击后todo
                 });
           },
         );
 ```


默认spaceMode=true效果
https://github.com/liuwangle/flutter_refresh_loadmore/blob/master/demon_gif/refresh.gif


默认spaceMode=false效果
https://github.com/liuwangle/flutter_refresh_loadmore/blob/master/demon_gif/loadmore.gif