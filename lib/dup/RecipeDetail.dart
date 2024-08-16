// import 'package:cookingai/CustomBottomNavigationBar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
// import 'package:flutter/widgets.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:http/http.dart' as http;

// class PreperationCard extends StatelessWidget {
//   final String stepNumber;
//   final String steps;

//   const PreperationCard({
//     Key? key,
//     required this.stepNumber,
//     required this.steps,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//       child: Card(
//         color: const Color(0xFFF1F1F1), // Use constants for clarity
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//         child: Container(
//           // Adjust width based on design or use MediaQuery
//           width: double.infinity, // Example: 80% of screen width
//           height: 56, // Adjust height as needed
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                   child: Text(
//                     stepNumber,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   steps,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                   ),
//                   overflow: TextOverflow.ellipsis, // Truncate if needed
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: SizedBox(width: 10),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PreparationStepWidget extends StatelessWidget {
//   final List<String> preparationSteps;

//   PreparationStepWidget({
//     required this.preparationSteps,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: preparationSteps.asMap().entries.map((entry) {
//         final stepNumber =
//             (entry.key + 1).toString(); // Adding 1 to index to get step number
//         final step = entry.value;
//         return PreperationCard(
//           stepNumber: stepNumber,
//           steps: step,
//         );
//       }).toList(),
//     );
//   }
// }

// class IngredientsListWidget extends StatelessWidget {
//   final List<String> ingredientsList;

//   IngredientsListWidget({required this.ingredientsList});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(ingredientsList.length, (index) {
//         final backgroundcolor =
//             index % 2 == 0 ? const Color(0xFFF1F1F1) : Colors.white;
//         final ingredient = ingredientsList[index].split(' - ');
//         final text1 =
//             ingredient.length > 1 ? ingredient[0] : ingredientsList[index];
//         final text2 = ingredient.length > 1
//             ? ingredient[1]
//             : ''; // If no '-', set text2 to empty string
//         return IngredientsWidget(
//           text1: text1,
//           text2: text2,
//           backgroundcolor: backgroundcolor,
//         );
//       }),
//     );
//   }
// }

// class IngredientsWidget extends StatelessWidget {
//   final String text1;
//   final String text2;
//   final Color backgroundcolor;

//   const IngredientsWidget({
//     Key? key,
//     required this.text1,
//     required this.text2,
//     required this.backgroundcolor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 32,
//       color: backgroundcolor,
//       padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(
//             text1,
//             style: const TextStyle(fontSize: 12),
//           ),
//           Text(
//             text2,
//             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RecipeDetails extends StatefulWidget {
//   const RecipeDetails({Key? key}) : super(key: key);

//   @override
//   State<RecipeDetails> createState() => _RecipeDetailsState();
// }

// class _RecipeDetailsState extends State<RecipeDetails> {
  
//   Map<String, dynamic> preparationData = {
//     "Difficulty Level": "Easy",
//     "Ingredients Required": [
//       "Carrots - 100 grams",
//       "Onion - 1 medium",
//       "Green chilies - 2",
//       "Ginger-garlic paste - 1 tablespoon",
//       "Turmeric powder - 1/2 teaspoon",
//       "Red chili powder - 1 teaspoon",
//       "Coriander powder - 1 teaspoon",
//       "Garam masala - 1/2 teaspoon",
//       "Oil - 2 tablespoons",
//       "Salt to taste"
//     ],
//     "Name of the Dish": "Ramen",
//     "Servings": "2-3",
//     "Step-by-Step Instructions": [
//       "Peel and cut the carrots into thin slices.",
//       "Chop the onion and green chilies.",
//       "Heat oil in a pan over medium heat.",
//       "Add the onions and green chilies and sauté until softened.",
//       "Add the ginger-garlic paste and sauté for a minute.",
//       "Add the turmeric powder, red chili powder, coriander powder, and garam masala and stir well.",
//       "Add the carrot slices and salt to taste.",
//       "Stir well and cook for 5-7 minutes, or until the carrots are tender.",
//       "Garnish with coriander leaves and serve hot."
//     ],
//     "Time to Make": "15 minutes"
//   };

//   @override
//   Widget build(BuildContext context) {
//     List<String> stepByStepInstructions =
//         List<String>.from(preparationData['Step-by-Step Instructions'] ?? []);
//     final List<String> ingredientsRequired =
//         List<String>.from(preparationData['Ingredients Required'] ?? []);
//     String timeToMake = preparationData["Time to Make"] ?? "";
//     String difficuilityLevel = preparationData["Difficulty Level"] ?? "";
//     String serving = preparationData["Servings"] ?? "";
//     String nameOfDish = preparationData["Name of the Dish"] ?? "";

//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavigationBar(),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(top: 24.0, left: 20.0),
//                 width: 24.0,
//                 height: 24.0,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24.0),
//                     color: Color(0xFFFFD634)),
//                 alignment: Alignment.center,
//                 child: Icon(
//                   CupertinoIcons.left_chevron,
//                   color: Color(0xFF030303),
//                   size: 17.0,
//                 ),
//               ),
//               // Container(
//               //   margin: EdgeInsets.only(left: 20, top: 20),
//               //   child: const Align(
//               //     alignment: Alignment.topLeft,
//               //     child: Text(
//               //       "Spicy",
//               //       style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, top: 0),
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     nameOfDish,
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
//                 child: Image(
//                   image: AssetImage('assets/images/ramen.jpeg'),
//                   height: 218,
//                   width: 375,
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 13),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         Icon(CupertinoIcons.clock),
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             timeToMake,
//                             style: TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w500),
//                           ),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Icon(CupertinoIcons.hand_thumbsup_fill),
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             difficuilityLevel,
//                             style: TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w500),
//                           ),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Icon(MdiIcons.pasta),
//                         Padding(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             serving + ' servings',
//                             style: TextStyle(
//                                 fontSize: 12, fontWeight: FontWeight.w500),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 color: Color.fromARGB(255, 223, 221, 221),
//                 thickness: 1.5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       'Ingredients for servings',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                     ),
//                     // ElevatedButton(
//                     //   style: ElevatedButton.styleFrom(
//                     //       backgroundColor:
//                     //           const Color.fromARGB(255, 241, 241, 241),
//                     //       side: BorderSide(color: Colors.yellow, width: 1.0)),
//                     //   onPressed: () => {},
//                     //   child: Text(serving),
//                     // )
//                   ],
//                 ),
//               ),

//               IngredientsListWidget(ingredientsList: ingredientsRequired),
//               const SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20),
//                 child: const Text(
//                   'Preparation',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               PreparationStepWidget(preparationSteps: stepByStepInstructions),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
