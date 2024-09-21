// screens/auth_screen.dart

// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:my_news/utils/routes.dart';
import 'package:my_news/utils/theme.dart';
import 'package:my_news/widgets/custom_button.dart';
import 'package:my_news/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/auth_provider.dart';

// AuthScreen is the main authentication screen for login and signup
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Text controllers to handle user input for name, email, and password
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Boolean to toggle between login and signup forms
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    // Accessing the AuthProvider for login/signup methods
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FD),
      body: SingleChildScrollView(
        child: SafeArea(
          // Ensures UI avoids system areas
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // App title at the top
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text('MyNews',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: ThemeUtil.baseColor)),
                ),
                Column(
                  children: [
                    // Name input field shown only if in signup mode
                    if (!_isLogin)
                      CustomTextField(
                        labelText: "Name",
                        controller: _nameController,
                        bgColor: Colors.white,
                        enteredTextColor: Colors.black,
                        contBorder:
                            Border.all(width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        height: 40,
                      ),
                    const SizedBox(height: 16),
                    // Email input field
                    CustomTextField(
                      labelText: "Email",
                      controller: _emailController,
                      bgColor: Colors.white,
                      enteredTextColor: Colors.black,
                      contBorder:
                          Border.all(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                      height: 40,
                    ),
                    const SizedBox(height: 16),
                    // Password input field
                    CustomTextField(
                      labelText: "Password",
                      enteredTextColor: Colors.black,
                      controller: _passwordController,
                      borderRadius: BorderRadius.circular(10),
                      height: 40,
                      obsecureText: true, // Password hidden for security
                      bgColor: Colors.white,
                      contBorder:
                          Border.all(width: 0, color: Colors.transparent),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // Login/Signup button with conditional text
                    CustomButton(
                      bgColor: ThemeUtil.baseColor,
                      titleStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      title: _isLogin ? 'Login' : 'SignUp',
                      width: 200,
                      onPressed: () async {
                        // Fetching and trimming input values
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final name = _nameController.text.trim();

                        // Handle login process
                        if (_isLogin) {
                          if (await authProvider.signIn(
                              context, email, password)) {
                            // Navigate to home screen on successful login
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.homeScreen);
                          } else {
                            // Show error toast if login fails
                            Fluttertoast.showToast(
                              msg:
                                  'Login failed. Please check your credentials.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        } else {
                          // Handle signup process
                          if (await authProvider.signUp(
                              context, email, password, name)) {
                            // Navigate to home screen on successful signup
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.homeScreen);
                          } else {
                            // Log error message on signup failure
                            print('Sign up failed');
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    // Toggle between login and signup
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text indicating current form mode
                          Text(
                            _isLogin ? 'New here?' : 'Already have an account?',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          // Switch between login and signup
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLogin = !_isLogin; // Toggle form mode
                              });
                            },
                            child: Text(
                              _isLogin ? 'SignUp' : 'Login',
                              style: TextStyle(
                                  color: ThemeUtil.baseColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
