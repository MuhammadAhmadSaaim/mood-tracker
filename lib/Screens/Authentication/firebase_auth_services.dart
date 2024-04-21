import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/toast.dart';

class FirebaseAuthService{
  FirebaseAuth auth= FirebaseAuth.instance;

  Future<User?> signUpWithEmailPassword(String email, String password) async{
    try{
      UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){

      if(e.code=='email-already-in-use'){
        showToast(messege: 'The email is already in use.');
      }else{
        showToast(messege: 'An Error Occurred: ${e.code}');
      }

    }
    return null;
  }

  Future<User?> signInWithEmailPassword(String email, String password) async{
    try{
      UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){

      if(e.code=='user-not-found'||e.code=='wrong-password'){
        showToast(messege: 'Invali Email Or Password');
      }else{
        showToast(messege: 'An Error Occurred: ${e.code}');
      }


    }
    return null;
  }

}