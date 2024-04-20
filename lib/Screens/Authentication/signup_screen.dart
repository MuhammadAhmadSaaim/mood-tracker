import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/Authentication/login_screen.dart';

import '../../widgets/authTextfield.dart';
import '../../widgets/button.dart';


class SignupScreen extends StatelessWidget {

  SignupScreen({super.key});
  //controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //for button
  void signinUser(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                //logo
                const Icon(
                  Icons.app_registration_rounded,
                  size: 100,
                ),
                const SizedBox(height: 10,),
                //Text
                Text(
                  "Create an Account",
                  style: TextStyle(color: Colors.grey[700],fontSize: 16),
                ),
                const SizedBox(height: 25,),
                //username
                MyTextField(
                  contorller: usernameController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10,),
                //password
                MyTextField(
                  contorller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                //name
                MyTextField(
                  contorller: passwordController,
                  hintText: "Name",
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                //age
                MyTextField(
                  contorller: passwordController,
                  hintText: "Age",
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                //forget password
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
                //login button
                MyButton(ontap: signinUser,btntext: "Sign up"),

                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text( // Moved the child property here
                        "Login",
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
