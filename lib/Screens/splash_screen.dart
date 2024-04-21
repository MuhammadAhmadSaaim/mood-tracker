import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/Authentication/firebase_cloudFirestore.dart';
import 'package:moodtracker/Screens/Authentication/login_screen.dart';
import 'package:moodtracker/Screens/switch_screens.dart';
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
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                        child: Image.asset(
                          'images/appIcon.png',
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    AnimatedOpacity(
                        duration: Duration(milliseconds: 1100),
                        opacity: animatet1 ? 1 : 0,
                        child: RichText(
                          text: TextSpan(
                            text: "Mood Tracker",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Trinidad',
                                fontSize: 20,
                                letterSpacing: .5),
                          ),
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => animatet1 = true);
    await Future.delayed(Duration(milliseconds: 1000));

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        print("Logged in as: ${user.email}");
        getData(user.email);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SwitchScreen(userid: user.email!)));
      } else {
        print("no user signed in");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }
}
