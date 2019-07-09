import 'package:flutter/material.dart';

class SquareIndicator extends StatefulWidget {
  int length;
  int select;
  final Widget selectorWidget;
  final Widget normalWidget;

  SquareIndicator(
      {Key key,
      this.length,
      this.select,
      this.selectorWidget,
      this.normalWidget})
      : super(key: key);
  MSquareIndicator mSquareIndicator;

  @override
  State<StatefulWidget> createState() {
    if (mSquareIndicator == null) {
      mSquareIndicator = MSquareIndicator();
    }
    return mSquareIndicator;
  }
}

class MSquareIndicator extends State<SquareIndicator> {
  List<Widget> points() {
    List<Widget> list ;
    for (var i = 0; i < widget.length; i++) {
      if (list == null) {
        list = new List();
      }
      list.add(_getWidget(i));
    }
    if (list == null) {
      list = new List();
      list.add(Container());
    }
    return list;
  }

  Widget _getWidget(int i) {
    int index = widget.select;

    if (index == i) {
      if (widget.selectorWidget != null) {
        return widget.selectorWidget;
      }
      return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        width: 10,
        height: 4,
        color: Color.fromARGB(255, 153, 153, 153),
      );
    } else {
      if (widget.normalWidget != null) {
        return widget.normalWidget;
      }
      return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        width: 10,
        height: 4,
        color: Color.fromARGB(255, 255, 255, 255),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: points(),
    );
  }

  updateWidgets(int length, int select) {
    widget.length = length;
    widget.select = select;
    setState(() {});
  }
}
