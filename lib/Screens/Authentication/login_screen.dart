import 'package:flutter/material.dart';

import '../../widgets/authTextfield.dart';
import '../../widgets/button.dart';


class LoginPage extends StatelessWidget {

  LoginPage({super.key});
  //controllers
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();
  //for button
  void signinUser(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              //logo
              const SizedBox(height: 50,),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 50,),
              //Text
              Text(
                "Welcome back you\ 've been missed!",
                style: TextStyle(color: Colors.grey[700],fontSize: 16),
              ),
              const SizedBox(height: 25,),
              //username
              MyTextField(
                contorller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),

              const SizedBox(height: 15,),
              //password
              MyTextField(
                contorller: passwordController,
                hintText: "Password",
                obscureText: true,
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
              MyButton(ontap: signinUser,),

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
                  Text(
                    "Register Now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
