import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Modals/person.dart';
import '../main.dart';
import 'Authentication/login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController reasonController = TextEditingController();
  List<String> feelingsList = [
    "Happiness",
    "Sadness",
    "Anger",
    "Fear",
    "Surprise",
    "Disgust",
    "Excitement",
    "Love",
    "Confusion",
    "Calmness",
    "Guilt",
    "Shame",
    "Loneliness",
    "Hope",
    "Pride",
  ]; // List of feelings

  String selectedFeeling = "Happiness"; // Default selected feeling

  @override
  void initState() {
    print(currPerson);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery
        .of(context)
        .size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mood Tracker"),
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()));
            }, icon: Icon(Icons.logout_rounded), color: Colors.black,)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to the Mood Tracker!",
                style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                "How is your mood today?",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedFeeling,
                      items: feelingsList.map((String feeling) {
                        return DropdownMenuItem<String>(
                          value: feeling,
                          child: Text(feeling),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFeeling = newValue ?? selectedFeeling;
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      dropdownColor: Colors.grey[300],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.black),
                    onPressed: () => _showAddFeelingDialog(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: "Reason for this mood",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save feeling logic (not implemented)
                },
                child: Text("Save Feeling"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddFeelingDialog(BuildContext context) {
    final TextEditingController feelingNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Add New Feeling")),
          content: SizedBox(
            width: 450,
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: feelingNameController,
                  decoration: InputDecoration(
                    labelText: "Feeling Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                IconButton(
                  icon: Icon(Icons.emoji_emotions, color: Colors.black),
                  onPressed: () {
                    // Emoji selection logic (not implemented)
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newFeeling = feelingNameController.text;
                setState(() {
                  feelingsList.add(newFeeling);
                });
                Navigator.of(context).pop();
              },
              child: Text("Add"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.grey[300],
              ),
            ),
          ],
        );
      },
    );
  }
}