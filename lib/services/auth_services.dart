// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  Future<User?> signUp(String email, String password, String name) async {
    try {
      // Create the user in Firebase Authentication
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user object
      User? user = result.user;

      if (user != null) {
        // Update the display name in Firebase Auth
        await user.updateDisplayName(name);
        await user.reload(); // Refresh user to apply displayName change

        // Save user info to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': name,
          'displayName': user.displayName,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Fluttertoast.showToast(
          msg: 'Sign-up successful!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      return user;
    } catch (e) {
      print('Error during sign-up: $e');

      Fluttertoast.showToast(
        msg: '$e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      // Sign in the user with Firebase Auth
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user object
      User? user = result.user;

      if (user != null) {
        // Check if user data already exists in Firestore
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!doc.exists) {
          // If the user is logging in for the first time, store their info in Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': user.email,
            'name': user.displayName ?? 'User',
            'displayName': user.displayName ?? 'User',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        Fluttertoast.showToast(
          msg: 'Sign-in successful!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      return user;
    } catch (e) {
      print('Error during sign-in: $e');

      Fluttertoast.showToast(
        msg: '$e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
