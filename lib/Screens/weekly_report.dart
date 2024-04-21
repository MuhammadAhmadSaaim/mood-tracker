import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/Modals/person.dart';
import '../Modals/mood.dart';
import 'package:flutter_emoji/flutter_emoji.dart' as emoji;

class WeeklyMoodList extends StatefulWidget {
  const WeeklyMoodList({Key? key}) : super(key: key);

  @override
  _WeeklyMoodListState createState() => _WeeklyMoodListState();
}

class _WeeklyMoodListState extends State<WeeklyMoodList> {
  late Future<List<MoodEntry>> weeklyMoodEntries;
  double averageMood=0.0;
  String moodImprovementSuggestion = '';

  @override
  void initState() {
    super.initState();
    weeklyMoodEntries = getMoodEntriesPastWeek(currPerson.email);
  }

  String getMoodImprovementSuggestion(double averageMoodScore) {
    if (averageMoodScore >= 4.8) {
      return "Exceptional week! Reflect on what's working and set ambitious yet achievable goals.";
    } else if (averageMoodScore >= 4.6) {
      return "Outstanding week! Prioritize activities that bring joy and practice daily gratitude.";
    } else if (averageMoodScore >= 4.4) {
      return "Amazing week! Dedicate time daily for mindfulness practices.";
    } else if (averageMoodScore >= 4.2) {
      return "Fantastic week! Nurture relationships and express gratitude.";
    } else if (averageMoodScore >= 4.0) {
      return "Great week! Stay consistent with self-care routines and explore new hobbies.";
    } else if (averageMoodScore >= 3.8) {
      return "Very good week! Prioritize activities that recharge you.";
    } else if (averageMoodScore >= 3.6) {
      return "Solid week! Reflect on areas for improvement and set goals.";
    } else if (averageMoodScore >= 3.4) {
      return "Positive week! Stay active and appreciate the simple moments.";
    } else if (averageMoodScore >= 3.2) {
      return "Good week! Focus on self-care and pleasure.";
    } else if (averageMoodScore >= 3.0) {
      return "Decent week! Reflect on accomplishments and seek balance.";
    } else if (averageMoodScore >= 2.8) {
      return "Okay week. Inject positivity and seek personal connection.";
    } else if (averageMoodScore >= 2.6) {
      return "Average week. Focus on self-care and reaching out for support.";
    } else if (averageMoodScore >= 2.4) {
      return "Below average week. Engage in fulfilling activities and prioritize self-care.";
    } else if (averageMoodScore >= 2.2) {
      return "Consider doing enjoyable activities more often and practicing mindfulness.";
    } else if (averageMoodScore >= 2.0) {
      return "Okay week. Infuse positivity into daily life and spend time with loved ones.";
    } else if (averageMoodScore >= 1.8) {
      return "Fair week. Focus on self-improvement and relaxation.";
    } else {
      return "Challenging week. Prioritize self-care and seek support if needed.";
    }
  }


  static double getMoodScore(String mood) {
    switch (mood.toLowerCase()) {
      case "happy":
        return 5.0;
      case "sad":
        return 1.0;
      case "anxious":
        return 2.5;
      case "smile":
      case "grin":
      case "heart_eyes":
      case "relaxed":
      case "relieved":
      case "heart_eyes_cat":
      case "kissing_closed_eyes":
      case "blush":
      case "innocent":
      case "kissing_heart":
      case "kissing":
      case "stuck_out_tongue_closed_eyes":
      case "stuck_out_tongue_winking_eye":
      case "stuck_out_tongue":
      case "wink":
      case "yum":
        return 4.0;
      case "cry":
      case "disappointed":
      case "weary":
      case "sob":
      case "pensive":
      case "worried":
        return 2.0;
      case "angry":
      case "fearful":
      case "rage":
      case "scream":
      case "sweat":
      case "flushed":
      case "grimacing":
      case "lying_face":
      case "neutral_face":
      case "expressionless":
      case "sunglasses":
      case "unamused":
      case "sweat_smile":
      case "zipper_mouth_face":
        return 3.0;
      default:
        return 0.0; // Default score for unknown mood
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('Weekly Mood List',style: TextStyle(color: Colors.white),),
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
            if (moodEntries.isEmpty) {
              return Center(child: Text('No Mood Entries Made'));
            }
            moodEntries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

            double totalMoodScore = 0;
            for (var entry in moodEntries) {
              totalMoodScore += getMoodScore(entry.emoji);
            }
            averageMood = totalMoodScore / moodEntries.length;

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: moodEntries.length + 2, // Add 1 for the average mood score and 1 for suggestion
              itemBuilder: (context, index) {
                if (index == moodEntries.length + 1) {
                  // This is the last item, show average mood score
                  return Card(
                    elevation: 3, // Adding elevation
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15), // Adjust margins
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10), // Adjust padding
                      title: Text(
                        'Suggestion:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(getMoodImprovementSuggestion(averageMood)),
                    ),
                  );
                } 
                else if (index == moodEntries.length) {
                  // This is the last item, show average mood score
                  return Card(
                    elevation: 3, // Adding elevation
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15), // Adjust margins
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10), // Adjust padding
                      title: Text(
                        'Average Mood Score',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        averageMood.toStringAsFixed(1), // Display average mood score
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                else {
                  // Display mood entry
                  final moodEntry = moodEntries[index];
                  return Card(
                    elevation: 3, // Adding elevation
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15), // Adjust margins
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 10,right: 10), // Adjust padding
                      leading: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // Rounded corners
                        ),
                        child: Text(
                          emoji.EmojiParser().get(moodEntry.emoji).code,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      title: Text(
                        moodEntry.mood,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      ),
                      subtitle: Text(moodEntry.reason),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('EEE').format(moodEntry.timestamp), // Day of the week (e.g., Mon)
                            style: TextStyle(fontSize: 12, color: Colors.pink.shade900),
                          ),
                          SizedBox(height: 4), // Add some space between day of the week and date
                          Text(
                            DateFormat('dd MMM yyyy').format(moodEntry.timestamp), // Date (e.g., 21 Apr 2024)
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );

          }
        },
      ),
    );
  }
}
