import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/Screens/home_screen.dart';
import 'package:moodtracker/Screens/monthly_report.dart';
import 'package:moodtracker/Screens/weekly_report.dart';

class SwitchScreen extends StatefulWidget {
  String userid = "";

  SwitchScreen({required this.userid});

  @override
  State<SwitchScreen> createState() =>
      SwitchScreenState(this.userid);
}

class SwitchScreenState extends State<SwitchScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;
  String userid = "";
  SwitchScreenState(this.userid); // constructor?

  final db = FirebaseFirestore.instance; // FireStore instance

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            HomePage(),
            WeeklyMoodList(),
            MonthlyMoodList(),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? Transform.scale(
                  scale: 1.5,
                  child: Text("Home", style: TextStyle(color: Colors.white),),
                )
                    : Text("Home", style: TextStyle(color: Colors.white),),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? Transform.scale(
                  scale: 1.5,
                  child: Text("Weekly", style: TextStyle(color: Colors.white),),
                )
                    : Text("Weekly", style: TextStyle(color: Colors.white),),
                label: 'Weekly Report',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? Transform.scale(
                  scale: 1.5,
                  child: Text("Monthly", style: TextStyle(color: Colors.white),),
                )
                    : Text("Monthly", style: TextStyle(color: Colors.white),),
                label: 'Monthly Report',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
