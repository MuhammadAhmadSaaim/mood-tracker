import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moodtracker/Screens/Authentication/login_screen.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  bool animatet1 = false;


  @override
  void initState() {
    super.initState();
    startAnimation();
    Future.delayed(Duration(milliseconds: 2000), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
              left: mq.width * .25,
              top: mq.height * .35,
              width: mq.width * .5,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                        duration: Duration(milliseconds: 700),
                        opacity: animate ? 1 : 0,
                        child: Image.asset('images/appIcon.png',)
                    ),
                    AnimatedOpacity(
                        duration: Duration(milliseconds: 1100),
                        opacity: animatet1 ? 1 : 0,
                        child: RichText(text: TextSpan(
                          text: "Mood Tracker",
                          style: TextStyle(color: Colors.white, fontFamily: 'Trinidad', fontSize: 40, letterSpacing: .5),
                        ),
                        )
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => animatet1 = true);
    await Future.delayed(Duration(milliseconds: 2000));
  }
}

