import 'package:flutter/material.dart';

const primaryColor = Colors.white;
const secondaryColor = Color(0xff3A3B56);
const buttonColor = Color.fromRGBO(247, 64, 106, 1.0);


final themeData = ThemeData(
    //primaryColor: defaultColor,
    brightness: Brightness.dark,
    primaryColor: secondaryColor,
    cardColor: const Color(0xff40415D),
    scaffoldBackgroundColor: secondaryColor,
    inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        labelStyle: TextStyle(color: Colors.white)));


List<Color> _colors = [secondaryColor, const Color.fromARGB(255, 67, 104, 154)];
List<double> _stops = [0.0, 0.8];

final boxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: _colors,
    stops: _stops,
  ));


//estilo default p/ textos em inputs do login
const hintTextStyle = TextStyle(
  color: primaryColor,
  fontFamily: 'OpenSans',
);

//estilo default para as labels do login
const labelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w500,
  fontFamily: 'OpenSans',
);

//estilo default para as labels do login
const labelStyleGreen = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
