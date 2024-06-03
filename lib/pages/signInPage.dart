import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_me/auth/firebaseLogin.dart';
import 'package:help_me/components/clipContainer.dart';
import 'package:help_me/pages/exercise/exerciseCategoryDisplayPage.dart';
import 'package:help_me/pages/loginPage.dart';
import 'package:help_me/pages/rootPage.dart';
// import '../../extraStuff/exerciseDisplay.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController SecondPasswordController =
      TextEditingController();

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool makePasswordVisibleOne = true;
  bool makePasswordVisibleTwo = true;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpUser(
      BuildContext context, String email, String password) async {
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email in incorrect format',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the function if the email format is incorrect
    }
    try {
      // Create a new user with the provided email and password
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Check if the user creation was successful
      if (userCredential.user != null) {
        print('User signed up successfully.');
        // Navigate to the HomePage if the sign-up is successful
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      print('Failed to sign up: $e');
      // Displaying a Snackbar for error handling
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign up: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  final AuthService _authService = AuthService();

  Future<void> _signInWithGoogle() async {
    try {
      UserCredential? userCredential = await _authService.signInWithGoogle();

      if (userCredential != null) {
        // Save login status when sign-in is successful
        // await saveLoginStatus(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ExerciseDisplayCategory()), // Make sure you have a DisplayScreen widget
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in aborted by user'),
            backgroundColor: Colors.amber,
          ),
        );
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              width: 280,
              height: 170,
              child: Image.asset(
                'public/assets/images/logo.jpg',
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                  child: Text(
                    'Register',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    width: 250,
                    child: Text(
                      'Create a new account',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Email',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 16),
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 237, 237),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1)),
                    child: TextField(
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                      controller: widget.emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Password',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 10),
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Color.fromARGB(255, 237, 237, 237),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      obscureText: !makePasswordVisibleOne,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                      controller: widget.passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              makePasswordVisibleOne = !makePasswordVisibleOne;
                            });
                          },
                          icon: makePasswordVisibleOne
                              ? Icon(Icons.energy_savings_leaf)
                              : Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 12),
                  child: Text(
                    'Re-enter password',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 10),
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Color.fromARGB(255, 237, 237, 237),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      obscureText: !makePasswordVisibleTwo,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      )),
                      controller: widget.SecondPasswordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              makePasswordVisibleTwo = !makePasswordVisibleTwo;
                            });
                          },
                          icon: makePasswordVisibleTwo
                              ? Icon(Icons.energy_savings_leaf)
                              : Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.white,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    child: Text(
                      'I agree to the Terms and Conditions',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                signUpUser(
                  context,
                  widget.emailController.text,
                  widget.passwordController.text,
                );
              },
              child: Container(
                width: width * 0.7,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  'SIGN UP',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPageWidget()));
              },
              child: Container(
                width: width * 0.7,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  'LOGIN',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
