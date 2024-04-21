import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart' as emoji;
import 'package:moodtracker/Screens/monthly_report.dart';
import 'package:moodtracker/Screens/weekly_report.dart';
import 'package:moodtracker/widgets/toast.dart';
import '../Modals/mood.dart';
import '../Modals/person.dart';
import 'Authentication/login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedMood = '';
  String reason = '';

  List<Mood> moods = [
    Mood(name: 'Happiness/Joy', emoji: 'smile'),
    Mood(name: 'Sadness', emoji: 'cry'),
    Mood(name: 'Anger', emoji: 'angry'),
    Mood(name: 'Fear', emoji: 'fearful'),
    Mood(name: 'Surprise', emoji: 'surprised'),
    Mood(name: 'Disgust', emoji: 'disappointed'),
    Mood(name: 'Excitement', emoji: 'grin'),
    Mood(name: 'Love/Affection', emoji: 'heart_eyes'),
    Mood(name: 'Confusion', emoji: 'confused'),
    Mood(name: 'Calmness', emoji: 'relaxed'),
    Mood(name: 'Guilt', emoji: 'weary'),
    Mood(name: 'Shame', emoji: 'sob'),
    Mood(name: 'Loneliness', emoji: 'pensive'),
    Mood(name: 'Hope', emoji: 'pray'),
    Mood(name: 'Pride', emoji: 'grinning'),
  ];

  void saveFeeling() async {
    if (selectedMood.isNotEmpty && reason.isNotEmpty) {
      // Fetch the emoji corresponding to the selected mood
      String selectedEmoji =
          moods.firstWhere((mood) => mood.name == selectedMood).emoji;

      // Create a mood entry object
      MoodEntry moodEntry =
          MoodEntry(mood: selectedMood, emoji: selectedEmoji, reason: reason);

      final db = FirebaseFirestore.instance;
      final moodEntryData = moodEntry.toJson();

      db
          .collection('mood_entries')
          .doc(currPerson.email)
          .update({
            'mood_entries_list': FieldValue.arrayUnion([moodEntryData])
          })
          .then((_) => showToast(messege: "Mood entry added successfully"))
          .catchError(
              (error) => showToast(messege: "Error adding mood entry: $error"));
    } else {
      // Handle case where either mood or reason is empty
      showToast(messege: 'Mood or reason is empty');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mood Tracker"),
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginPage()));
              },
              icon: Icon(Icons.logout_rounded),
              color: Colors.black,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, ${currPerson.name.toUpperCase()}",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 50),
                Text(
                  'How are you feeling?',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Add border color
                    borderRadius: BorderRadius.circular(8.0), // Add border radius
                  ),
                  child: DropdownButton<String>(
                    value: selectedMood.isEmpty ? null : selectedMood,
                    hint: Text('Select a mood'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMood = newValue!;
                      });
                    },
                    underline: Container(),
                    items: moods.map<DropdownMenuItem<String>>((Mood mood) {
                      return DropdownMenuItem<String>(
                        value: mood.name,
                        child: Row(
                          children: [
                            Text(
                              emoji.EmojiParser().get(mood.emoji).code,
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(width: 8.0),
                            Text(mood.name),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Reason for this mood:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  onChanged: (value) {
                    reason = value;
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write your reason here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: saveFeeling,
                  child: Text('Save Feeling'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeeklyMoodList()));
                  },
                  child: Text('Weekly'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MonthlyMoodList()));
                  },
                  child: Text('Monthly'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
