import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/Authentication/signup_screen.dart';
import 'package:moodtracker/Screens/temp.dart';

import '../../main.dart';
import '../../widgets/authTextfield.dart';
import '../../widgets/Authbutton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formValidationKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool passHidden = true;

  @override
  void initState() {
    super.initState();
    passHidden = true;
  }

  void signInUser() {
    if (formValidationKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => temp()),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * .12,
                  ),
                  // Logo
                  SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Text
                  Text(
                    "Welcome!",
                    // Removed unnecessary escape character
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Username
                  // Username
                  AuthTextField(
                    controller: emailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress, // Set keyboard type to email address
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add more custom validation logic as needed
                      return null; // Return null if validation passes
                    },
                  ),
                  SizedBox(height: mq.height*.01,),
                  AuthTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.fingerprint_outlined,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add more custom validation logic as needed
                      return null; // Return null if validation passes
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // Forget password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Login button
                  AuthButton(
                    ontap: signInUser,
                    btntext: "Sign in",
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                          child: Text("Register Now",
                            style: TextStyle(
                              color: Colors.pink.shade900,
                              fontWeight: FontWeight.bold,
                            ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
