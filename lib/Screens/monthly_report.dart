import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodtracker/Modals/person.dart';
import '../Modals/mood.dart';
import 'package:flutter_emoji/flutter_emoji.dart' as emoji;

class MonthlyMoodList extends StatefulWidget {
  const MonthlyMoodList({Key? key}) : super(key: key);

  @override
  _MonthlyMoodListState createState() => _MonthlyMoodListState();
}

class _MonthlyMoodListState extends State<MonthlyMoodList> {
  late Future<List<MoodEntry>> monthlyMoodEntries;
  double averageMood=0.0;
  String moodImprovementSuggestion = '';

  @override
  void initState() {
    super.initState();
    monthlyMoodEntries = getMoodEntriesPastMonth(currPerson.email);
  }

  String getMoodImprovementSuggestion(double averageMoodScore) {
    if (averageMoodScore >= 4.8) {
      return "You had an exceptional month! Reflect on the factors contributing to your high mood and consider incorporating them into your routine consistently. Challenge yourself to set ambitious yet achievable goals and celebrate your progress along the way.";
    } else if (averageMoodScore >= 4.6) {
      return "You experienced a truly outstanding month! Continue prioritizing activities that bring you joy and fulfillment. Practice gratitude daily to maintain your positive outlook and spread kindness to those around you.";
    } else if (averageMoodScore >= 4.4) {
      return "You had an amazing month! Keep embracing the habits and routines that uplift you. Dedicate time each day for mindfulness practices to enhance your mental well-being and cultivate inner peace.";
    } else if (averageMoodScore >= 4.2) {
      return "You had a fantastic month! Maintain your positive momentum by nurturing your relationships and engaging in activities that bring you happiness. Take moments to reflect on your achievements and express gratitude for the blessings in your life.";
    } else if (averageMoodScore >= 4.0) {
      return "You had a great month! Stay consistent with your self-care routines and make time for relaxation. Consider exploring new hobbies or revisiting old ones to keep your spirits high and your mind engaged.";
    } else if (averageMoodScore >= 3.8) {
      return "You had a very good month! Continue to invest in your well-being by prioritizing activities that recharge you. Practice self-compassion and be gentle with yourself during challenging times.";
    } else if (averageMoodScore >= 3.6) {
      return "You had a solid month! Reflect on areas where you can further improve your mood and make adjustments accordingly. Set aside moments for self-reflection and personal growth.";
    } else if (averageMoodScore >= 3.4) {
      return "You had a positive month! Keep up the good work by staying active and engaged in life. Take time to appreciate the beauty around you and find joy in the simple moments.";
    } else if (averageMoodScore >= 3.2) {
      return "You had a good month! Maintain your optimism by focusing on the positives in your life. Make self-care a priority and carve out time for activities that bring you pleasure and relaxation.";
    } else if (averageMoodScore >= 3.0) {
      return "You had a decent month! Reflect on your accomplishments and areas for growth. Strive for balance in your life by attending to your physical, emotional, and mental well-being.";
    } else if (averageMoodScore >= 2.8) {
      return "You had an okay month. Identify areas where you can inject more positivity and purpose into your daily routine. Practice gratitude and seek out opportunities for personal connection and growth.";
    } else if (averageMoodScore >= 2.6) {
      return "You had an average month. Focus on self-care and finding moments of joy amidst the challenges. Reach out to loved ones for support and cultivate a sense of community.";
    } else if (averageMoodScore >= 2.4) {
      return "You had a slightly below average month. Take proactive steps to lift your mood by engaging in activities that bring you pleasure and fulfillment. Prioritize self-care and seek out sources of inspiration.";
    } else if (averageMoodScore >= 2.2) {
      return "You had a good month! Consider doing activities you enjoy more often. Take time to explore new hobbies or revisit old ones that bring you joy. Additionally, incorporating mindfulness practices such as meditation or deep breathing exercises can help you maintain your positive momentum.";
    } else if (averageMoodScore >= 2.0) {
      return "You had an okay month. Find ways to infuse more positivity into your daily life. Practice gratitude and spend time with loved ones to boost your mood.";
    } else if (averageMoodScore >= 1.8) {
      return "You had a fair month. Focus on self-improvement and setting realistic goals. Take breaks when needed and engage in activities that promote relaxation and well-being.";
    } else {
      return "You had a challenging month. It's important to prioritize self-care and seek professional help if needed. Take small steps to nurture yourself, such as practicing mindfulness, engaging in creative activities, or spending time with supportive people. Remember that seeking help is a sign of strength, and there are resources available to support you through difficult times.";
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
        title: Text('Monthly Mood List',style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<List<MoodEntry>>(
        future: monthlyMoodEntries,
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
                if (index == moodEntries.length+1) {
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
