import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  final String uid;
  DbService({this.uid});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String phnumber, String username) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'phnumber': phnumber, 'username': username});
  }

  Future<void> saveEmailPassword(String email, String password) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .update({'email': email, 'password': password});
    return;
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
