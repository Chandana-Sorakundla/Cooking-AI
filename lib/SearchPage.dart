import 'package:cookingai/ChatPage.dart';
import 'package:cookingai/CustomBottomNavigationBar.dart';
import 'package:cookingai/HomePage.dart';
import 'package:cookingai/RecipeDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<String> searchHistory = [];
  int _currentIndex = 1; // Assuming that SearchPage is at index 1

  void addToSearchHistory(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      setState(() {
        searchHistory.insert(0, searchQuery);
      });
    }
  }





  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          // Use pushReplacement to avoid building a large stack of pages
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        // Current index is search, so we do nothing
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ChatPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
//       appBar:AppBar(
//   leading: Container(
//     margin: EdgeInsets.only(top: 24.0, left: 20.0),
//     width: 24.0,
//     height: 24.0,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(24.0),
//       color: Color(0xFFFFD634),
//     ),
//     child: Material(
//       color: Colors.transparent, // Avoids the splash effect color
//       child: InkWell(
//         onTap: () {
//           if (Navigator.of(context).canPop()) {
//             Navigator.of(context).pop();
//           }
//         },
//         borderRadius: BorderRadius.circular(24.0), // Match the Container's border radius
//         child: Icon(
//           CupertinoIcons.left_chevron,
//           color: Color(0xFF030303),
//           size: 17.0,
//         ),
//       ),
//     ),
//   ),
// ),

        // title: Text('Search', style: TextStyle(color: Colors.black)),
        // backgroundColor: Colors.white,
        // elevation: 2, // Gives a slight shadow for the AppBar
    
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             Padding(
               padding: const EdgeInsets.fromLTRB(25.0,25,0,0),
               child: Text('Search',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 33),),
             ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onSubmitted: (String searchQuery) {
          if (searchQuery.isNotEmpty) {
            addToSearchHistory(searchQuery);
            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetails(searchTerm: searchQuery),
        ),
            );
          }
        },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xf070707),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), 
        
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                    
                  ),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.yellow, width: 1.0), // Set your border color here
        ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,15,0),
                    child: Icon(Icons.search, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchHistory[index]),
                    leading: Icon(Icons.history),
                    onTap: () {
                      // Implement what happens when you tap an item in the history
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
            bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,)

    );
  }
}
