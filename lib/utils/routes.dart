import 'package:flutter/material.dart';
import 'package:my_news/screens/auth_screen.dart';
import 'package:my_news/screens/home_screen.dart';
import 'package:my_news/screens/news_detail_screen.dart';
import 'package:my_news/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String authScreen = '/auth';
  static const String homeScreen = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      splashScreen: (context) => const SplashScreen(),
      authScreen: (context) => const AuthScreen(),
      homeScreen: (context) => const HomeScreen(),
    };
  }
}
