// providers/auth_provider.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news/widgets/loading.dart';
import '../services/auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// AuthProvider class to manage authentication state with ChangeNotifier for state management
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService(); // Instance of AuthService
  User? _user; // Current authenticated user

  // Getter for accessing the authenticated user
  User? get user => _user;

  // Sign up method
  Future<bool> signUp(
      BuildContext context, String email, String password, String name) async {
    // Check if any of the fields are empty
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter Email, Password,  name',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false; // Return false if validation fails
    }

    // Show loading dialog while sign-up is in progress
    Loading.dialog(context);

    // Call the signUp method from AuthService
    _user = await _authService.signUp(email, password, name);

    // Close the loading dialog after completion
    Navigator.pop(context);

    // Notify listeners that the authentication state has changed
    notifyListeners();

    // Return true if sign-up was successful, otherwise false
    return _user != null;
  }

  // Sign in method
  Future<bool> signIn(
      BuildContext context, String email, String password) async {
    // Check if email or password fields are empty
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg:
            'Please enter Email, Password', // Show error message if fields are empty
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false; // Return false if validation fails
    }

    // Show loading dialog while sign-in is in progress
    Loading.dialog(context);

    // Call the signIn method from AuthService
    _user = await _authService.signIn(email, password);

    // Close the loading dialog after completion
    Navigator.pop(context);

    // Notify listeners that the authentication state has changed
    notifyListeners();

    // Return true if sign-in was successful, otherwise false
    return _user != null;
  }

  // Sign out method
  Future<void> signOut() async {
    // Call the signOut method from AuthService
    await _authService.signOut();

    // Set _user to null after sign-out
    _user = null;

    // Notify listeners that the authentication state has changed
    notifyListeners();
  }
}
