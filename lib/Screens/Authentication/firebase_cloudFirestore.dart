import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Modals/mood.dart';
import '../../Modals/person.dart';

Future<void> getData(String? userid) async {
  final currentUser = FirebaseFirestore.instance
      .collection("users")
      .doc(userid); // get the document reference from collection
  await currentUser.get().then(
        (value) {
          currPerson = Person.fromJson(value.data()!);
    },
    onError: (e) => print("Error getting document: $e"),
  );
}