import 'package:flutter/material.dart';
import 'package:yaamfoo/component/text_field_container.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String image;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.image ,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: ColorValues.TEXT_COLOR,
        decoration: InputDecoration(
          suffixIcon:    new Container(
           padding: EdgeInsets.all(13.0),
            child: new Center(
            child:new Image.asset(image),),
            width: 15.0,
            height: 15.0,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: ColorValues.HINT_TEXT_COLOR,
            fontSize: 15.0,
            fontFamily: "customLight",

          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
