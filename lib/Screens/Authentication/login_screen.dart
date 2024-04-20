import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/Authentication/signup_screen.dart';

import '../../widgets/authTextfield.dart';
import '../../widgets/button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key}); // Added `Key` parameter and fixed typo in constructor

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function for button
  void signinUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                // Logo
                const SizedBox(height: 50,),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50,),
                // Text
                Text(
                  "Welcome back you've been missed!", // Removed unnecessary escape character
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25,),
                // Username
                MyTextField(
                  contorller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 15,),
                // Password
                MyTextField(
                  contorller: passwordController, // Corrected typo
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                // Forget password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                // Login button
                MyButton(ontap: signinUser,btntext: "Sign in",),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      },
                      child: Text( // Moved the child property here
                        "Register Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
