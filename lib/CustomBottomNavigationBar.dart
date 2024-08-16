import 'package:cookingai/SearchPage.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(254, 214, 52, 1),
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        if (index == 1) {
          // Assuming that the search icon is at index 1
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        }
      },
      selectedItemColor: Colors.black,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '',
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: '',
        ),
      ],
    );
  }
}
