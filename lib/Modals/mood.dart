import 'package:cloud_firestore/cloud_firestore.dart';

class Mood {
  late final String name;
  late final String emoji;

  Mood({required this.name, required this.emoji});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emoji': emoji,
    };
  }

  factory Mood.fromMap(Map<String, dynamic> map) {
    return Mood(
      name: map['name'],
      emoji: map['emoji'],
    );
  }
}



class MoodEntry {
  final String mood;
  final String emoji;
  final String reason;
  final DateTime timestamp; // New field for timestamp

  MoodEntry({
    required this.mood,
    required this.emoji,
    required this.reason,
    DateTime? timestamp, // Optional parameter for timestamp
  }) : timestamp = timestamp ?? DateTime.now(); // Assign current datetime if not provided

  Map<String, dynamic> toMap() {
    return {
      'mood': mood,
      'emoji': emoji,
      'reason': reason,
      'timestamp': timestamp.toIso8601String(), // Convert DateTime to string
    };
  }


  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'emoji': emoji,
      'reason': reason,
      'timestamp': timestamp.toIso8601String(), // Convert DateTime to string
    };
  }
}

// Function to get mood entries from current time to past one week
Future<List<MoodEntry>> getMoodEntriesPastWeek(String userEmail) async {
  final DateTime currentTime = DateTime.now();
  final DateTime oneWeekAgo = currentTime.subtract(const Duration(days: 7));

  final DocumentSnapshot<Map<String, dynamic>>? querySnapshot = await FirebaseFirestore.instance
      .collection('mood_entries')
      .doc(userEmail)
      .get();

  final List<MoodEntry> moodEntries = [];

  if (querySnapshot != null && querySnapshot.exists) {
    final List<dynamic>? entries = querySnapshot.data()?['mood_entries_list'];

    if (entries != null) {
      entries.forEach((entry) {
        DateTime entryTimestamp = DateTime.parse(entry['timestamp']);
        if (entryTimestamp.isAfter(oneWeekAgo) && entryTimestamp.isBefore(currentTime)) {
          moodEntries.add(MoodEntry(
            mood: entry['mood'],
            emoji: entry['emoji'],
            reason: entry['reason'],
            timestamp: entryTimestamp,
          ));
        }
      });
    }
  }

  return moodEntries;
}

// Function to get mood entries from current time to past one month
Future<List<MoodEntry>> getMoodEntriesPastMonth(String userEmail) async {
  final DateTime currentTime = DateTime.now();
  final DateTime oneMonthAgo = currentTime.subtract(const Duration(days: 30));

  final DocumentSnapshot<Map<String, dynamic>>? querySnapshot = await FirebaseFirestore.instance
      .collection('mood_entries')
      .doc(userEmail)
      .get();

  final List<MoodEntry> moodEntries = [];

  if (querySnapshot != null && querySnapshot.exists) {
    final List<dynamic>? entries = querySnapshot.data()?['mood_entries_list'];

    if (entries != null) {
      entries.forEach((entry) {
        DateTime entryTimestamp = DateTime.parse(entry['timestamp']);
        if (entryTimestamp.isAfter(oneMonthAgo) && entryTimestamp.isBefore(currentTime)) {
          moodEntries.add(MoodEntry(
            mood: entry['mood'],
            emoji: entry['emoji'],
            reason: entry['reason'],
            timestamp: entryTimestamp,
          ));
        }
      });
    }
  }

  return moodEntries;
}