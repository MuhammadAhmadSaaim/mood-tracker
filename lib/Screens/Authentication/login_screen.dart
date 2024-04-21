import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/Authentication/forget_pass.dart';
import 'package:moodtracker/Screens/Authentication/signup_screen.dart';
import 'package:moodtracker/widgets/toast.dart';

import '../../main.dart';
import '../../widgets/authTextfield.dart';
import '../../widgets/Authbutton.dart';
import '../../widgets/custom_loadin_bar.dart';
import '../switch_screens.dart';
import 'firebase_auth_services.dart';
import 'firebase_cloudFirestore.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final formValidationKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signInUser() async {
    if (formValidationKey.currentState!.validate()) {
      setState(() {
        isSigning = true;
      });

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      User? user = await _auth.signInWithEmailPassword(email, password);
      setState(() {
        isSigning = false;
      });
      if (user != null) {

        showToast(messege: "User Successfully SignedIn");
        print("Logged in as: ${user.email}");
         getData(user.email);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => SwitchScreen(userid: user.email!,))); //if created go directly to home screen
      } else {
        showToast(messege: "Some Error Occurred");
      }
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
              child: Form(
                key: formValidationKey,
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
                      keyboardType: TextInputType.emailAddress,
                      // Set keyboard type to email address
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Add more custom validation logic as needed
                        return null; // Return null if validation passes
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ForgetPass()));
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // Login button
                    isSigning
                        ? CustomLoadingBar()
                        : AuthButton(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.pink.shade900,
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
        ),
      ),
    );
  }
}
