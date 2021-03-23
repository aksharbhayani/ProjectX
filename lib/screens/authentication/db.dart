import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_app/screens/home_screen/Screen%203/addnote.dart';

class DbService {
  final String uid;
  DbService({this.uid});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String phnumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phnumber': phnumber,
    });
  }

  Future<void> saveEmailPassword(String email, String password) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .update({'email': email, 'password': password});
    return;
  }

  Future<void> saveNotes(String title, String content) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .update({'title': tittleControl.text, 'content': contentControl.text});
    return;
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
