// screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:my_news/utils/routes.dart';
import 'package:my_news/widgets/loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.authScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
            "assets/images/mynews.jpeg"), // Custom loading indicator widget
      ),
    );
  }
}
