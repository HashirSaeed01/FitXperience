import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_me/firebase_options.dart';
import 'package:help_me/pages/exercise/exerciseCategoryDisplayPage.dart';
import 'package:help_me/pages/food/foodDisplayWidget.dart';
import 'package:help_me/pages/food/foodHomePage.dart';
import 'package:help_me/pages/loginPage.dart';
import 'package:help_me/pages/profilePage.dart';
import 'package:help_me/pages/rootPage.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Check if the user is already logged in
  // bool userLoggedIn = await isLoggedIn();

  runApp(ProviderScope(
    child: MainApp(
        // userLoggedIn: userLoggedIn
        ),
  ));
}

class MainApp extends StatelessWidget {
  // final bool userLoggedIn;

  const MainApp({
    super.key,
    //  required this.userLoggedIn
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: userLoggedIn ? displayPage() : loginPage(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// // Function to save login status
// Future<void> saveLoginStatus(bool isLoggedIn) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('isLoggedIn', isLoggedIn);
// }

// // Function to check if user is logged in
// Future<bool> isLoggedIn() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('isLoggedIn') ?? false;
// }
