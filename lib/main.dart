import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memories/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memories',
      theme: _buildTheme(Brightness.dark),
      home: Home(),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.reggaeOneTextTheme(baseTheme.textTheme),
    );
  }
}
