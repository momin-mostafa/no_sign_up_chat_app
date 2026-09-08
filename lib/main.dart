import 'package:addiits_technology_practical_test/features/join/join.view.dart';
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: ChatAppColors.indigo),
        scaffoldBackgroundColor: ChatAppColors.white,
        useMaterial3: true,
        inputDecorationTheme: InputDecorationThemeData(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ChatAppColors.indigo),
          ),
          prefixIconColor: ChatAppColors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ChatAppColors.indigo,
            foregroundColor: ChatAppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: ChatAppColors.deepGrey),
        ),
      ),
      home: JoinView(),
    );
  }
}
