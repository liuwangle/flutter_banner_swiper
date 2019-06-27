import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_banner_swiper/banner_indicator.dart';

typedef GetWidgetCallback = Widget Function(int index);

class BannerSwiper extends StatefulWidget {
  int length = 0;
  GetWidgetCallback getwidget;
  int width;
  int height;
  Widget selectorWidget;
  Widget normalWidget;
  bool autoLoop;
  bool showIndicator;
  bool spaceMode;
  BannerSwiper({Key key, this.length = 0, this.getwidget,@required this.width,@required this.height,this.selectorWidget,this.normalWidget,this.autoLoop=true,this.showIndicator=true,this.spaceMode=true});

  @override
  State<StatefulWidget> createState() {
    return _BannerSwiperState();
  }
}

class _BannerSwiperState extends State<BannerSwiper> {
  @override
  void didUpdateWidget(BannerSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("--------------------didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("--------------------deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    print("--------------------dispose");
  }

  PageController _pageController = null;
  int _currentIndex = 100;
  Timer _timer;

  //设置定时器
  _setTimer() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      print(
          "----------------------------------_currentIndex   ${_currentIndex}");
      _pageController.animateToPage(_currentIndex + 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return getBanner2();
  }

  int bannerMax = 10000000000;

  double mywidth = 0;

  SquareIndicator squareIndicator;

  GlobalKey<MSquareIndicator> indicatorKey=GlobalKey<MSquareIndicator> ();

  double viewportFractionCustom=1;
  double paddingCustom=0;
  Widget getBanner2() {
    if(widget.spaceMode){
      viewportFractionCustom=0.925;
      paddingCustom=0.0125;
    }
    mywidth = MediaQuery.of(context).size.width;

    if (widget.length > 0 && _pageController == null) {


      _pageController = new PageController(
          initialPage: widget.length * 100, viewportFraction: viewportFractionCustom);
      _currentIndex = widget.length * 100;

      if(widget.autoLoop){
        _setTimer();
      }

    }
    if (widget.length == 0) {
      return Container();
    }
    PageView pageView = new PageView.builder(
      itemBuilder: ((context, index) {
        GlobalKey _key = new GlobalKey();
        Container cc = Container(
          key: _key,
          //左右两个padding
          margin:
          EdgeInsets.only(left: mywidth * paddingCustom, right: mywidth * paddingCustom),
          width: mywidth,

          height: mywidth * (viewportFractionCustom-paddingCustom*2) * widget.width / widget.height,
          child: widget.getwidget(index),
        );

        return cc;
      }),
      itemCount: bannerMax,
      scrollDirection: Axis.horizontal,
      reverse: false,
      controller: _pageController,
      physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
      onPageChanged: ((index) {
//        setState(() {
        _currentIndex = index;
        if(indicatorKey.currentState!=null){
          print("rrrrrrrrrrrrrrrrrrrrrrrrr  ccccc  ");
          indicatorKey.currentState.updateWidgets(widget.length,(_currentIndex) % widget.length);
        }else{
          print("rrrrrrrrrrrrrrrrrrrrrrrrr  rrrrrr  ");
        }
//        squareIndicator.createState().setState((){});
//        });
      }),
    );
    if(widget.showIndicator){
      squareIndicator = SquareIndicator(
        normalWidget: widget.normalWidget,
        selectorWidget: widget.selectorWidget,
        key: indicatorKey,
        length: widget.length,
        select: (_currentIndex) % widget.length,
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * widget.width / widget.height * (viewportFractionCustom-paddingCustom*2),
      child: Stack(
        children: <Widget>[
          pageView,
          _getSquareIndicator()
        ],
      ),
    );
  }
 Widget _getSquareIndicator(){
    if(widget.showIndicator){
      return Positioned(
        bottom: mywidth * 0.02,
        left: 0,
        right: 0,
        child: squareIndicator,
      );
    }else{
      return Container();
    }

  }

}
