import 'package:flutter/material.dart';

class CustomLoadingBar extends StatelessWidget {
  const CustomLoadingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make button full width
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child:  CircularProgressIndicator(
            color: Colors.white,
          )

        ),
      ),
    );
  }
}
