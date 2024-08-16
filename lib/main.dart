import 'package:cookingai/HomePage.dart';
import 'package:cookingai/RecipeDetail.dart';
import 'package:cookingai/SearchPage.dart';
import 'package:cookingai/Welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}
