// main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_news/provider/auth_provider.dart';
import 'package:my_news/provider/news_provider.dart';
import 'package:my_news/utils/routes.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My News',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'WorkSans',
        ),
        // home: const AuthScreen(),
        initialRoute: AppRoutes.splashScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
