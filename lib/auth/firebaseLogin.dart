import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _firebaseAuth.signInWithCredential(credential);
      }
      return null;
    } catch (e) {
      print('Error signing in with Google: $e');
      throw Exception(
          'Meow'); // You might want to rethrow to handle this exception higher up
    }
  }

  /// Registers a new user with an email and password and assigns a role to them.
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      // Create a new user with email and password
      UserCredential newUserCreds = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = newUserCreds.user;

      if (user != null) {
        // Add a new document in 'users' collection with the user's role
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set({'email': email, 'role': role});

        // Optionally, if you want to do something with the document reference
        // DocumentReference docRef = _firestore.collection('users').doc(user.uid);
        // Here you might access docRef for other purposes, but not for set() return.
      } else {
        throw Exception('User not created');
      }

      return newUserCreds;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Authentication errors
      print('Firebase Auth Error: User already exists');
      throw Exception(e.message);
    } catch (e) {
      // Handle other errors
      print('General Error: $e');
      throw Exception('Failed to register user.');
    }
  }
}

// Future<UserCredential?> signInWithFacebook() async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login();

//     if (result.status == LoginStatus.success) {
//       final AccessToken accessToken = result.accessToken!;
//       final AuthCredential credential =
//           FacebookAuthProvider.credential(accessToken.token);

//       return await _firebaseAuth.signInWithCredential(credential);
//     } else {
//       print('Error signing in with Facebook: ${result.message}');
//       throw Exception('Failed to sign in with Facebook');
//     }
//   } catch (e) {
//     print('Error signing in with Facebook: $e');
//     throw Exception('Failed to sign in with Facebook');
//   }
// }


