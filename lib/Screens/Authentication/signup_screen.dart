import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodtracker/Screens/Authentication/firebase_auth_services.dart';
import 'package:moodtracker/widgets/toast.dart';
import '../../Modals/person.dart';
import '../../main.dart';
import '../../widgets/authTextfield.dart';
import '../../widgets/back_button.dart';
import '../../widgets/Authbutton.dart';
import '../../widgets/custom_loadin_bar.dart';
import '../home_screen.dart';
import '../switch_screens.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isSigning = false;

  final formValidationKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();

  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    if (formValidationKey.currentState!.validate()) {
      setState(() {
        isSigning = true;
      });
      String name = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String age = ageController.text.trim();
      User? user = await _auth.signUpWithEmailPassword(email, password);

      setState(() {
        isSigning = false;
      });
      if (user != null) {
        showToast(messege: "Account Successfully Created");
        Person person = Person(
          name: name,
          email: email,
          age: age,
        );
        currPerson=person;
        final db = FirebaseFirestore.instance;
        db
            .collection('users')
            .doc(person.email)
            .set(person.toJson())
            .onError((error, stackTrace) => print("Error writing document $error"));

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => SwitchScreen(userid: user.email!,))); // //if created go directly to home screen
      } else {
        showToast(messege: 'Some Error Occurred');
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
                        if (value.length < 6 ) {
                          return 'Password Must be atleast 6 characters long';
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
                    isSigning
                        ? CustomLoadingBar()
                        : AuthButton(
                            ontap: signUpUser,
                            btntext: "Sign in",
                          ),
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
