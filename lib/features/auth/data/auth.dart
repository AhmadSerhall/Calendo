import 'dart:developer';

import 'package:admin/app/data.dart';
import 'package:admin/core/dialogs/custom_dialog.dart';
import 'package:admin/features/auth/data/providers/auth_providers.dart';
import 'package:admin/features/home/presentation/pages/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Flexify.go(const HomeScreen());
    } on FirebaseAuthException catch (e) {
      globalRef!.read(isLoginLoadingProvider.notifier).state = false;
      log('firebase exception');
      log(e.code);

      log(e.message ?? '');
      if (e.code == 'invalid-credential') {
        showDialogError(
          'Invalid Credentials',
          'Invalid login credentials. Kindly double-check your email and password.',
          context,
        );
        return "Invalid login credentials. Kindly double-check your email and password.";
      } else {
        return e.message;
      }
    } catch (e) {
      return 'Unexpected error has occured, please try again later.';
    }
  }

  signUpWithEmail(String name, String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.runTransaction((transaction) async {
        // Create user data
        final userDocRef = _firestore.collection('users').doc(result.user!.uid);
        transaction.set(userDocRef, {
          'uid': result.user!.uid,
          'name': name,
          'email': email,
          'isAdmin': false,
          'isApproved': false,
        });
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Flexify.go(const HomeScreen());
      return 'success';
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      // Handle specific errors
      if (e.code == 'email-already-in-use') {
        return 'The email address is already in use. Please use a different email.';
      } else {
        return 'Registration failed. Please try again later.';
      }
    } catch (e) {
      // Handle other non-authentication errors
      return 'Unexpected error occurred. Please try again.';
    }
  }
}
