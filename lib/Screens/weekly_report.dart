import 'package:flutter/material.dart';
import 'package:moodtracker/Modals/person.dart';
import '../Modals/mood.dart';
import 'package:flutter_emoji/flutter_emoji.dart' as emoji;

import 'home_screen.dart';

class WeeklyMoodList extends StatefulWidget {
  const WeeklyMoodList({Key? key}) : super(key: key);

  @override
  _WeeklyMoodListState createState() => _WeeklyMoodListState();
}

class _WeeklyMoodListState extends State<WeeklyMoodList> {
  late Future<List<MoodEntry>> weeklyMoodEntries;

  @override
  void initState() {
    super.initState();
    weeklyMoodEntries = getMoodEntriesPastWeek(currPerson.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Mood List'),
      ),
      body: FutureBuilder<List<MoodEntry>>(
        future: weeklyMoodEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final moodEntries = snapshot.data!;
            return ListView.builder(
              itemCount: moodEntries.length,
              itemBuilder: (context, index) {
                final moodEntry = moodEntries[index];
                return ListTile(
                  leading: Text(
                    emoji.EmojiParser().get(moodEntry.emoji).code,
                    style: TextStyle(fontSize: 24),
                  ),
                  title: Text(moodEntry.mood),
                  subtitle: Text(moodEntry.reason),
                  trailing: Text(moodEntry.timestamp.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
