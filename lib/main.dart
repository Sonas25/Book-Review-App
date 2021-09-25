import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(BookReview());

class BookReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Review App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}