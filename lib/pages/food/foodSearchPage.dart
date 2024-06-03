// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:help_me/pages/food/foodDetailPage.dart';

// class FoodSearchPage extends StatefulWidget {
//   @override
//   _FoodSearchPageState createState() => _FoodSearchPageState();
// }

// class _FoodSearchPageState extends State<FoodSearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<String> _searchResults = [];

//   void _searchFood(String query) async {
//     // Implement API call to search for food items and update _searchResults
//     // For example: using Nutritionix API to fetch search results

//     // This is a placeholder for actual API response
//     setState(() {
//       _searchResults = ['Apple', 'Banana', 'Chicken Breast'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text('Search Food'),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CupertinoSearchTextField(
//               controller: _searchController,
//               onSubmitted: _searchFood,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_searchResults[index]),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) => FoodDisplayWidget(),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
