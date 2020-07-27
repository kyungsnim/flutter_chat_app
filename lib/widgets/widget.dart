import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text('Free Chatting',
      style: TextStyle(
        color: Colors.white,
        fontSize: 27,
        fontWeight: FontWeight.w800,
        shadows: [
          Shadow(
              color: Colors.green,
              offset: Offset(0.9, 0.9),
              blurRadius: 0.9
          )
        ]
      ),
    ),
    backgroundColor: Colors.lightGreen,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.black54
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightGreen
          )
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black54
          )
      ),
    );
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(
    color: Colors.black54,
    fontSize: 16
  );
}

TextStyle mediumTextFieldStyle() {
  return TextStyle(
      color: Colors.black54,
      fontSize: 20
  );
}