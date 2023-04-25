import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth extends ChangeNotifier {
  late final FirebaseAuth _auth;

  Auth() : _auth = FirebaseAuth.instance;
  User? user;

  bool get isAuth => _auth.currentUser != null && user != null;

  bool get isEmailVer {
    _auth.currentUser!.reload();
    bool isver = _auth.currentUser!.emailVerified;

    notifyListeners();
    return isver;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      user!.updateDisplayName(name);
      user!.sendEmailVerification();
      final docCollectionRef =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);

      await docCollectionRef.set({
        'name': name,
        'email': email,
        'postsId': [],
      });

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String? msg;
      if (e.code == 'email-already-in-use') {
        msg = 'Email Already in use.';
        print('Email Already in use.');
      } else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
        print('Invalid Email.');
      } else if (e.code == 'weak-password') {
        msg = 'Weak Password';
        print('Weak Password.');
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

  Future<void> signIn({required String email, required String password,required BuildContext context}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String? msg;
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password';
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        msg = 'Invalid Email.';
        print("Invalid Email");
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

  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
