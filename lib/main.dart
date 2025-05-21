import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Qur\'an App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}
