import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  final String uid;
  DbService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String phnumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phnumber': phnumber,
    });
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
