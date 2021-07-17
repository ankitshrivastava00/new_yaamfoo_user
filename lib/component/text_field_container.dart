import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
     // width: size.width * 0.8,
     // height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),

      ),
      child:new Center(
          child:child
      )
    );
  }
}
