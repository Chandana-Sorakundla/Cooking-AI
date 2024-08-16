import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cookingai/ChatPage.dart';
import 'package:cookingai/CustomBottomNavigationBar.dart';
import 'package:cookingai/HomePage.dart';
import 'package:cookingai/SearchPage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'api_service.dart';

class PreperationCard extends StatelessWidget {
  final String stepNumber;
  final String steps;

  const PreperationCard({
    Key? key,
    required this.stepNumber,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: const Color(0xFFF1F1F1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
           constraints: BoxConstraints(minHeight: 70),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    stepNumber,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  steps,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,),
                  
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

class PreparationStepWidget extends StatelessWidget {
  final List<String> preparationSteps;

  const PreparationStepWidget({Key? key, required this.preparationSteps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: preparationSteps.asMap().entries.map((entry) {
        final stepNumber = (entry.key + 1).toString();
        final step = entry.value;
        return PreperationCard(stepNumber: stepNumber, steps: step);
      }).toList(),
    );
  }
}

class IngredientsListWidget extends StatelessWidget {
  final List<String> ingredientsList;

  const IngredientsListWidget({Key? key, required this.ingredientsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(ingredientsList.length, (index) {
        final backgroundcolor = index % 2 == 0 ? const Color(0xFFF1F1F1) : Colors.white;
        final ingredient = ingredientsList[index].split(' - ');
        final text1 = ingredient.length > 1 ? ingredient[0] : ingredientsList[index];
        final text2 = ingredient.length > 1 ? ingredient[1] : '';
        return IngredientsWidget(text1: text1, text2: text2, backgroundcolor: backgroundcolor);
      }),
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Color backgroundcolor;

  const IngredientsWidget({Key? key, required this.text1, required this.text2, required this.backgroundcolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 36),
      color: backgroundcolor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Expanded(
                  child: Text(
                    text2,
                   
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Text(
            text1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class RecipeDetails extends StatefulWidget {
  final String searchTerm;

  const RecipeDetails({Key? key, required this.searchTerm}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  int _currentIndex = 1;
  bool _isLoading = true; // To control visibility of the progress indicator
  Map<String, dynamic> preparationData = {};
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchRecipeData(widget.searchTerm);
  }

  Future<void> fetchRecipeData(String searchTerm) async {
    try {
      Map<String, dynamic> data = await _apiService.fetchRecipeFromSearch(searchTerm);
      setState(() {
        preparationData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Hide the loading indicator in case of error too
      });
      print('Error fetching recipe data: ${e.toString()}');
    }
  }

  String getDifficulty(Map<String, dynamic> data) {
    return data['Difficulty Level'] ?? data['Difficulty'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show loading indicator while fetching data
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<String> stepByStepInstructions = List<String>.from(preparationData['Step-by-Step Instructions'] ?? []);
    List<String> ingredientsRequired = List<String>.from(preparationData['Ingredients Required'] ?? []);
    String timeToMake = preparationData["Time to Make"]?.toString() ?? "";
    String difficultyLevel = getDifficulty(preparationData);
    String serving = preparationData["Servings"]?.toString() ?? "";
    String nameOfDish = preparationData["Name of the Dish"] ?? "";

    // Content is displayed only after data is loaded
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    nameOfDish,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Image.asset('assets/images/ramen.jpeg', height: 218, width: double.infinity, fit: BoxFit.fitWidth),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoColumn(icon: CupertinoIcons.clock, text: timeToMake),
                    InfoColumn(icon: CupertinoIcons.hand_thumbsup_fill, text: difficultyLevel),
                    InfoColumn(icon: MdiIcons.pasta, text: '$serving servings'),
                  ],
                ),
                Divider(color: Color.fromARGB(255, 223, 221, 221), thickness: 1.5),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Ingredients for servings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                IngredientsListWidget(ingredientsList: ingredientsRequired),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Preperation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                PreparationStepWidget(preparationSteps: stepByStepInstructions),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
        break;
    }
  }
}

class InfoColumn extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoColumn({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
