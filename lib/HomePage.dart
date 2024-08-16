import 'package:cookingai/ChatPage.dart';
import 'package:cookingai/CustomBottomNavigationBar.dart';
import 'package:cookingai/ImageUploadPage.dart';
import 'package:cookingai/RecipeDetail.dart';
import 'package:cookingai/SearchPage.dart';
import 'package:cookingai/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cookingai/searchbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  
  int _currentIndex = 0; // This will keep track of the current index for the bottom navigation bar.

  // This method will be called when a navigation item is tapped.
  void _onItemTapped(int index) {
    if (index == _currentIndex) return; // Do nothing if the current tab is tapped again

    setState(() {
      _currentIndex = index; // Update the current index
    });

    switch (index) {
      case 0: // Home icon
        // We are already on the HomePage, no need to navigate
        break;
      case 1: // Search icon
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())); // Navigate to the SearchPage
        break;
      case 2: // Chat icon
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage())); // Navigate to the ChatPage
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SearchBarApp(),
                
                Container(
                  child: const Text('What are we cooking today?',style: TextStyle(
                  color: Color(0xFF030303), // Text color
                  fontSize: 32, // Font size in points
                  fontFamily: 'Be Vietnam Pro', // Font family
                  fontWeight: FontWeight.w600, // Font weight
                  height: 1.4, // Line height (assuming 'lineHeight' represents the line spacing)
                ),),
                
                ),
          
                const SizedBox(
                  height: 30,
                ),
            
                  const Text(
                    'Recipe of the day',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFFF030303),
                      fontSize: 18,
                      fontFamily: 'Be Vietnam Pro',
                      fontWeight: FontWeight.w600,
                      
                    ),
                  ),
                 
                  Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Container(
              color: Colors.transparent,
              child: Ink.image(
                      image: AssetImage('assets/images/recipe.jpeg'),
                      fit: BoxFit.cover,
                      width: double.infinity, // Take up all available width
                      height: 165, // Fixed height
                      child: InkWell(
                        onTap: () async {
    try {
      // Use your ApiService to fetch a random recipe.
      final recipe = await ApiService().fetchRandomRecipe();

      // Extracting the dish name from the recipe data.
      final String dishName = recipe['dish_name'];

      // Navigate to the recipe details page with the dish name.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetails(searchTerm: dishName),
        ),
      );
    } catch (e) {
      // If an error occurs, handle it appropriately.
      print("Error fetching random recipe: $e");
    }
  },
                        splashColor: Color.fromARGB(255, 155, 151, 151).withAlpha(30), // Custom splash color
                      ),
              ),
            ),
          ),
          
          
          
          
          
                  const SizedBox(
                    height: 40,
                  ),
                  Text('Ideas',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.w600 ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: <Widget>[
                      
                     Column(
                      
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
  child: Container(
    color: Colors.transparent,
    child: Ink.image(
      image: AssetImage('assets/images/food_camera_logo1.jpeg'),
      fit: BoxFit.cover,
      width: 160,  // Take up all available width
      height: 160,  // Fixed height
      child: InkWell(
        onTap: () async {
          // Open the ImageUploadPage and await the result
          final String dishName = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ImageUploadPage()
            )
          );
          // Navigate to the recipe details page if a dish name is returned
          if (dishName != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetails(searchTerm: dishName),
              ),
            );
          }
        },
        splashColor: Color.fromARGB(255, 155, 151, 151).withAlpha(30),
      ),
    ),
  ),
),
              const Padding(
                padding: EdgeInsets.fromLTRB(7, 10, 0, 0),
                child: Text(
          "Search by image",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
                ),
              ),
            ],
          ),
                        // SizedBox(
                        //   width: 10,
                        // ),
            Column(
              
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Container(
              color: Colors.transparent,
              child: Ink.image(
                      image: AssetImage('assets/images/food_search_img.png'),
                      fit: BoxFit.cover,
                      width: 160, // Take up all available width
                      height: 160, // Fixed height
                      child: InkWell(
                        onTap: () {
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
                        },
                        splashColor: Color.fromARGB(255, 155, 151, 151).withAlpha(30), // Custom splash color
                      ),
              ),
            ),
          ),
              const Padding(
                padding: EdgeInsets.fromLTRB(7, 10, 0, 0),
                child: Text(
          "Search by text",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
                ),
              ),
            ],
          ),
          
                        
                      // Image(image: AssetImage('assets/images/food_camera_logo2.jpeg'))
                    ],),
                  )    
              ],
            ),
                
            
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex, // Pass the current index here.
        onTap: _onItemTapped,) // Pass the onTap callback here.),
    );
  }
}