import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_classification/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Classification',
      home: MySplash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.grey,
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: const ColorScheme.light(
              primary: Colors.blueGrey, secondary: Colors.white)),
    );
  }
}
