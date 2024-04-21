import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/widgets/back_button.dart';
import 'package:moodtracker/widgets/toast.dart';
import '../../widgets/Authbutton.dart';
import '../../widgets/authTextfield.dart';


class ForgetPass extends StatefulWidget {
  ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showToast(messege: "Password reset email sent successfully");
      // You can show a message to the user indicating that the email has been sent
      Navigator.of(context).pop;
    } catch (e) {
      // Handle errors such as invalid email, user not found, etc.
      showToast(messege: "Error sending password reset email: $e");
      // You can show an error message to the user
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
                    const SizedBox(height: 50,),
                    // Logo
                    const SizedBox(height: 50,),
                    const Icon(
                      Icons.password,
                      size: 100,
                    ),
                    const SizedBox(height: 50,),
                    // Text
                    Text(
                      "Forget Password", // Removed unnecessary escape character
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    const SizedBox(height: 25,),
                    // Username
                    AuthTextField(
                      obscureText: false,
                      controller: emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 25,),
                    // Login button
                    AuthButton(
                      ontap: resetPassword, btntext: "Reset Password",),
                    const SizedBox(height: 25,),
                  ],
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