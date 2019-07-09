import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_banner_swiper/banner_indicator.dart';

typedef GetWidgetCallback = Widget Function(int index);

class BannerSwiper extends StatefulWidget {
  final int length  ;
  final GetWidgetCallback getwidget;
  final int width;
  final int height;
  final Widget selectorWidget;
  final  Widget normalWidget;
  final bool autoLoop;
  final bool showIndicator;
  final bool spaceMode;
  BannerSwiper({Key key, this.length, this.getwidget,@required this.width,@required this.height,this.selectorWidget,this.normalWidget,this.autoLoop=true,this.showIndicator=true,this.spaceMode=true});

  @override
  State<StatefulWidget> createState() {
    return _BannerSwiperState();
  }
}

class _BannerSwiperState extends State<BannerSwiper> {
  @override
  void didUpdateWidget(BannerSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
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
          indicatorKey.currentState.updateWidgets(widget.length,(_currentIndex) % widget.length);
        }else{
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
