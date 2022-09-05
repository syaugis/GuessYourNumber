import 'package:flutter/material.dart';
import 'package:guessyournumber/welcome_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guess Your Number",
      theme: ThemeData(fontFamily: "Poppins", primarySwatch: Colors.purple),
      home: const WelcomePage(),
    );
  }
}
