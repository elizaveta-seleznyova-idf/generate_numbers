import 'package:flutter/material.dart';
import 'package:presentation/screen/home/home_page.dart';

class GenerateNumbersApp extends StatelessWidget {
  const GenerateNumbersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generate',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
