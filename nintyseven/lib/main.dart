import 'package:flutter/material.dart';
import 'package:nintyseven/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 138, 75, 240));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 13, 48, 146));
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.onPrimaryContainer,
              foregroundColor: Colors.black),
        ),
        useMaterial3: true,
        cardTheme: CardTheme().copyWith(
            color: kDarkColorScheme.onPrimary,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                fontFamily: 'KurdishFont',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kColorScheme.onSecondaryContainer,
              )),
          cardTheme: const CardTheme().copyWith(
              color: const Color.fromARGB(255, 255, 184, 179),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 116, 250, 250),
                  foregroundColor: Colors.black)),
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
              centerTitle: true,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ))),
      home: const Expenses(),
    ),
  );
}
