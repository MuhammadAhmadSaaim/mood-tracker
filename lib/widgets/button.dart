import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btntext;
  final Function()? ontap;
   const MyButton({super.key,required this.ontap, required this.btntext});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            btntext,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
