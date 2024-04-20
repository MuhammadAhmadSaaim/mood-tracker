import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/Authentication/login_screen.dart';

import '../../main.dart';
import '../../widgets/authTextfield.dart';
import '../../widgets/back_button.dart';
import '../../widgets/Authbutton.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formValidationKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  void signUpUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: formValidationKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: mq.height * .1,
                    ),
                    //logo
                    const Icon(
                      Icons.app_registration_rounded,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Text
                    Text(
                      "Create an Account",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AuthTextField(
                      controller: usernameController,
                      labelText: 'Name',
                      prefixIcon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        // Add more custom validation logic as needed
                        return null; // Return null if validation passes
                      },
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    AuthTextField(
                      controller: emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Add more custom validation logic as needed
                        return null; // Return null if validation passes
                      },
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    AuthTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      prefixIcon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // Add more custom validation logic as needed
                        return null; // Return null if validation passes
                      },
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    AuthTextField(
                      controller: ageController,
                      labelText: 'Age',
                      prefixIcon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        // Add more custom validation logic as needed
                        return null; // Return null if validation passes
                      },
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    //username

                    const SizedBox(
                      height: 25,
                    ),
                    //login button
                    AuthButton(ontap: signUpUser, btntext: "Sign up"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: customBackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
