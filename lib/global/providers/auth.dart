import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late final FirebaseAuth _auth;

  Auth() : _auth = FirebaseAuth.instance;
  User? user;

  bool get isAuth => _auth.currentUser != null && user != null;
  
  // This Function returns whether the user's email is verified or not. 
  bool get isEmailVer {
    _auth.currentUser!.reload();
    bool isver = _auth.currentUser!.emailVerified;
    notifyListeners();
    return isver;
  }

  // This Function createUserId with Email and Password
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Create user id using email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Get currentUser
      user = credential.user;
      // Update the user name
      user!.updateDisplayName(name);
      // After users id have created send the email verification link. 
      user!.sendEmailVerification();

      // Get the Document Reference where the new users data will be stored in Firebase Firestore
      final docCollectionRef =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);

      // Set the users data to that reference
      await docCollectionRef.set({
        'name': name,
        'email': email,
        'postsId': [],
      });
      
      // TODO: implement authToken storage to persist user authentication state 
      // String authToken = await credential.user!
      //     .getIdToken(); // Generate a unique authentication token
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('authToken', authToken);
      notifyListeners();

    } on FirebaseAuthException catch (e) {

      // if any errors occurs show this SnackBar with error message. 
      String? msg;
      if (e.code == 'email-already-in-use') {
        msg = 'Email Already in use.';
      } else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      } else if (e.code == 'weak-password') {
        msg = 'Weak Password';
      }

      if (msg!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              msg,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            duration: const Duration(milliseconds: 2000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      }
    }
  }


  // This Function lets user sign in using email and password

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      // Sign in user with email and password. 
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      user = credential.user;
      notifyListeners();

    } on FirebaseAuthException catch (e) {
      // If any error occurs show bottom SnackBar. 

      String? msg;
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password';
      } else if (e.code == 'invalid-email') {
        msg = 'Invalid Email.';
      }

      if (msg!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              msg,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            duration: const Duration(milliseconds: 2000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      }
    }
  }

  // Sign out user 
  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
