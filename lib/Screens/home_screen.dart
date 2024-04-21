import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_emoji/flutter_emoji.dart' as emoji;
import 'package:moodtracker/widgets/Authbutton.dart';
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

  List<Mood> moods = [];

  @override
  void initState() {
    super.initState();
    fetchMoods();
  }

  void fetchMoods() async {
    try {
      final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('moods').get();

      final List<Mood> fetchedMoods = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Mood(name: data['name'], emoji: data['emoji']);
      }).toList();

      setState(() {
        moods = fetchedMoods;
      });
    } catch (error) {
      print('Error fetching moods: $error');
    }
  }

  void _showAddMoodDialog() {
    String newMoodName = '';
    String newMoodEmoji = '';

    // List of emojis to choose from
    List<String> emojis = [
      'smile',
      'cry',
      'angry',
      'fearful',
      'disappointed',
      'grin',
      'heart_eyes',
      'confused',
      'relaxed',
      'weary',
      'sob',
      'pensive',
      'pray',
      'grinning',
      'rage',
      'blush',
      'sleepy',
      'relieved',
      'heart_eyes_cat',
      'kissing_closed_eyes',
      'smirk',
      'unamused',
      'sweat_smile',
      'scream',
      'sweat',
      'flushed',
      'expressionless',
      'sunglasses',
      'grin',
      'grimacing',
      'lying_face',
      'neutral_face',
      'innocent',
      'kissing_heart',
      'kissing',
      'stuck_out_tongue_closed_eyes',
      'stuck_out_tongue_winking_eye',
      'stuck_out_tongue',
      'wink',
      'worried',
      'yum',
      'zipper_mouth_face',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Add New Mood'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  onChanged: (value) {
                    newMoodName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Mood Name',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DropdownButtonFormField<String>(
                      value: newMoodEmoji.isNotEmpty ? newMoodEmoji : null,
                      hint: Text('Select an emoji'),
                      onChanged: (String? newValue) {
                        setState(() {
                          newMoodEmoji = newValue!;
                        });
                      },
                      items: emojis.map((emojiName) {
                        return DropdownMenuItem<String>(
                          value: emojiName,
                          child: Row(
                            children: [
                              Text(
                                emoji.EmojiParser().get(emojiName).code,
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newMoodName.isNotEmpty && newMoodEmoji.isNotEmpty) {
                  // Add new mood to Firestore
                  FirebaseFirestore.instance.collection('moods').add({
                    'name': newMoodName,
                    'emoji': newMoodEmoji,
                  }).then((_) {
                    // Refresh local mood list from Firestore
                    fetchMoods();
                    showToast(messege: 'Mood added successfully');
                  }).catchError((error) {
                    showToast(messege: 'Error adding mood: $error');
                  });
                  Navigator.of(context).pop();
                } else {
                  showToast(
                      messege: 'Please provide both mood name and emoji');
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

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
  Widget build(BuildContext context) {
    if (moods.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                      ),
                      IconButton(
                        onPressed: _showAddMoodDialog,
                        icon: Icon(Icons.add_rounded),
                      ),
                    ],
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
                AuthButton(
                  ontap: saveFeeling,
                  btntext: 'Save Feeling',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
