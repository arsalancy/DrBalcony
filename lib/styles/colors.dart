import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 18, 107, 156),
      secondary: Color.fromARGB(255, 6, 144, 224),
      tertiary: Color.fromARGB(255, 255, 255, 255),
      background: Color(0xffEEF1F0),
      primaryContainer: Color.fromARGB(255, 158, 204, 226),
      secondaryContainer: Color.fromARGB(255, 18, 107, 156),
      tertiaryContainer: Color.fromARGB(255, 227, 232, 234),
    ),
    textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 233, 226, 226),
          //foreground: ,
          fontFamily: 'iransans',
          //color: Color(0xffC75E60),
          //fontSize: 10,
          //fontWeight: FontWeight.w600
        ),
        titleSmall: TextStyle(
            fontFamily: 'iransans', fontSize: 15, color: Color(0xff344C5D)),
        titleMedium: TextStyle(
          fontSize: 25,
          color: Color.fromARGB(255, 25, 122, 175),
          //foreground: ,
          fontFamily: 'iransans',
          //color: Color(0xffC75E60),
          //fontSize: 10,
          //fontWeight: FontWeight.w600
        ),
//   labelLarge:TextStyle(
//     fontFamily: 'iransans',
//   color: Color(0xffC75E60),
//  fontSize: 18,
//  fontWeight: FontWeight.w600
// ) ,
        displayMedium: TextStyle(
          fontSize: 13,
          color: Color.fromARGB(255, 89, 0, 0),
          //foreground: ,
          fontFamily: 'iransans',
          //color: Color(0xffC75E60),
          //fontSize: 10,
          //fontWeight: FontWeight.w600
        ),
        bodyLarge: TextStyle(
            fontFamily: 'iransans',
            color: Color.fromARGB(255, 18, 107, 156),
            fontSize: 15,
            fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(
          fontFamily: 'iransans',
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 158, 204, 226),
        ),
        headlineMedium: TextStyle(
            fontFamily: 'iransans',
            color: Color.fromARGB(255, 18, 107, 156),
            fontSize: 18,
            fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(
          fontFamily: 'iransans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 41, 40, 40),
        ),
        bodySmall: TextStyle(
          fontSize: 15,
          fontFamily: 'iransans',
          color: Color.fromARGB(255, 113, 164, 200),
        )));

final darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 18, 107, 156),
        // Color.fromARGB(255, 75, 97, 112),

        secondary: Color.fromARGB(255, 16, 127, 186),
        tertiary: Color.fromARGB(255, 255, 255, 255),
        //tertiary:Color(0xffF2AE5A) ,
        background: Color.fromARGB(255, 81, 120, 148),
        primaryContainer: Color.fromARGB(255, 158, 204, 226),
        secondaryContainer: Color.fromARGB(255, 18, 107, 156),
        tertiaryContainer: Color.fromARGB(255, 227, 232, 234)),
    textTheme: const TextTheme(
        displayMedium: TextStyle(
          fontSize: 13,
          color: Color.fromARGB(255, 89, 0, 0),
          //foreground: ,
          fontFamily: 'iransans',
          //color: Color(0xffC75E60),
          //fontSize: 10,
          //fontWeight: FontWeight.w600
        ),
        displaySmall: TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 233, 226, 226),
            //foreground: ,
            //fontWeight: FontWeight.w600,
            fontFamily: 'iransans',
            //color: Color(0xffC75E60),
            //fontSize: 10,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 25, 122, 175),
          //foreground: ,
          fontFamily: 'iransans',
          //color: Color(0xffC75E60),
          //fontSize: 10,
          //fontWeight: FontWeight.w600
        ),
        titleSmall: TextStyle(
            fontFamily: 'iransans',
            fontSize: 20,
            color: Color.fromARGB(255, 93, 129, 155)),
        bodyLarge: TextStyle(
          fontFamily: 'iransans',
          fontSize: 15,
          color: Color(0xffF2AE5A),
        ),
        headlineLarge: TextStyle(
          fontFamily: 'iransans',
          fontSize: 20,
          //fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 158, 204, 226),
        ),
        headlineMedium: TextStyle(
            fontFamily: 'iransans',
            color: Color.fromARGB(255, 18, 107, 156),
            fontSize: 18,
            fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(
          fontFamily: 'iransans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 41, 40, 40),
        ),
        bodySmall: TextStyle(
          fontSize: 15,
          fontFamily: 'iransans',
          color: Color.fromARGB(255, 113, 164, 200),
        )));
