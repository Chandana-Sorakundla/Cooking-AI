import 'package:cookingai/RecipeDetail.dart';
import 'package:flutter/material.dart';
import 'package:cookingai/HomePage.dart';



class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 350,
              width: double.infinity,
              child: SizedBox(
                width: 375,
      height: 411,
                child: Image(
                  image: AssetImage('assets/images/cookup_logo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: const <Widget>[
                  Text(
                    'Cookup!',
                    style: TextStyle(
                      color: Color(0xFF030303),
                      fontSize: 32,
                      fontFamily: 'Be Vietnam Pro',
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Easy & delicious recipes',
                    style: TextStyle(
                      color: Color(0xFF030303),
                      fontSize: 20,
                      fontFamily: 'Be Vietnam Pro',
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  
                  onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
},
                  
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Color(0xFF030303),
                      fontSize: 14,
                      fontFamily: 'Be Vietnam Pro',
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xffffd634), // Set button color
                    padding: EdgeInsets.symmetric(horizontal: 16), // Set padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Set border radius
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
