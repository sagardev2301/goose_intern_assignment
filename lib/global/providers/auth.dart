import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  late final FirebaseAuth _auth;

  Auth() : _auth = FirebaseAuth.instance;
  User? user;

  bool get isAuth => _auth.currentUser != null && user != null;

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      user!.updateDisplayName(name);

      user!.sendEmailVerification();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email Already in use.');
      } else if (e.code == 'invalid-email') {
        print('Invalid Email.');
      } else if (e.code == 'weak-password') {
        print('Weak Password.');
      }
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        print("Invalid Email");
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
