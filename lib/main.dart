import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "bloc app",
      debugShowCheckedModeBanner: false,
     theme: ThemeData(brightness: Brightness.dark,),
     home: Scaffold(),
    );
  }
}