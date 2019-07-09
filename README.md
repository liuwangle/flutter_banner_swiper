# flutter_banner_swiper

A banner swiper  package.

## Getting Started
Installing
 ```dart
flutter_banner_swiper: ^0.1.1
```

Import
 ```dart
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
```

How To Use

 最简单的应用
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
 复杂点的

 BannerSwiper(
       //是否显示指示器 默认true
       showIndicator: false,
       //是否自动循环翻页 默认true
       autoLoop: false,
       //自定义 未选中指示器
       normalWidget: Container(
         width: 10,
         height: 10,
         color: Colors.white,
       ),
       //自定义 选中指示器
       selectorWidget: Container(
         width: 10,
         height: 10,
         color: Colors.black38,
       ),

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


默认spaceMode=true效果
![image](https://github.com/liuwangle/flutter_banner_swiper/blob/master/png/space_mode.jpg)




默认spaceMode=false效果
![image](https://github.com/liuwangle/flutter_banner_swiper/blob/master/png/normal_mode.jpg)
