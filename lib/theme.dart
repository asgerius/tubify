import 'package:flutter/material.dart';

const _textColour = Color(0xFFEEEEEE);

const TextTheme textTheme = TextTheme(
  headline1: TextStyle(color: _textColour, fontSize: 28, fontWeight: FontWeight.bold),
  headline2: TextStyle(color: _textColour, fontSize: 26, fontWeight: FontWeight.bold),
  headline3: TextStyle(color: _textColour, fontSize: 24, fontWeight: FontWeight.bold),
  headline4: TextStyle(color: _textColour, fontSize: 22),
  headline5: TextStyle(color: _textColour, fontSize: 20),
  headline6: TextStyle(color: _textColour, fontSize: 18, fontWeight: FontWeight.bold),
  bodyText1: TextStyle(color: _textColour, fontSize: 18, fontWeight: FontWeight.normal),
  bodyText2: TextStyle(color: _textColour, fontSize: 16),
  button:    TextStyle(color: _textColour, fontSize: 20),
  overline:  TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: 0.4),
);

ThemeData themeData() => ThemeData(
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
  textTheme: textTheme,
  dialogBackgroundColor: Colors.black,
);
