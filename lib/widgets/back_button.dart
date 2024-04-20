import 'package:flutter/material.dart';

class customBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  customBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          "Back",
          style: TextStyle(color: Colors.pink.shade900),
        ),
      ),
    );
  }
}
