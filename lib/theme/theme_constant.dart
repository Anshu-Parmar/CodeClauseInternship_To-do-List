 import 'package:flutter/material.dart';

const COLOR_PRIMARY = Colors.orange;
const COLOR_ACCENT = Colors.orangeAccent;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  appBarTheme: const AppBarTheme(
    backgroundColor: COLOR_PRIMARY,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      backgroundColor: MaterialStateProperty.all<Color>(COLOR_PRIMARY)
    ),
  )
);

 ThemeData darkTheme = ThemeData(
   // brightness: Brightness.dark,
   colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white, brightness: Brightness.dark),
   switchTheme: SwitchThemeData(
     trackColor: MaterialStateProperty.all<Color>(Colors.grey),
     thumbColor: MaterialStateProperty.all<Color>(Colors.white),
   ),
   textTheme: const TextTheme(
     headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
     headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
     titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
   ),

     elevatedButtonTheme: ElevatedButtonThemeData(
       style: ButtonStyle(
           padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
               EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)
           ),
           shape: MaterialStateProperty.all<OutlinedBorder>(
               RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20.0)
               )
           ),
           backgroundColor: MaterialStateProperty.all<Color>(COLOR_PRIMARY)
       ),
     )
 );