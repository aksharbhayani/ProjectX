import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_app/models/user.dart';
import 'package:project_app/screens/alert.dart';
import 'package:project_app/screens/authentication/db.dart';
import 'package:project_app/screens/sign_in/components/sign_form.dart';
import 'package:project_app/screens/sign_up/components/signup_form.dart';

class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'ERROR_INVALID_EMAIL':
        return "The email address is badly formatted.";

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";

      case 'ERROR_WRONG_PASSWORD':
        return "E-mail address or password is incorrect.";

      default:
        return "An error has occurred";
    }
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var errorMessage;

  CustomUser _userFromFirebaseUser(User user) {
    firestoreInstance.collection("users").doc(user.uid).get().then((value) {
      namee = value.data()['name'];
      username = value.data()['username'];
      eemail = value.data()['email'];
      phoneno = value.data()['phnumber'];

      print(namee);
      print(username);
    });
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(Errors.show(e.code));
      final action = await RetryErrorDialogs.retryerrDialog(
          context, 'Error', Errors.show(e.code));
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print(name);
      print(phone);
      await DbService(uid: user.uid).updateUserData(name, phone, username);
      await DbService(uid: user.uid).saveEmailPassword(email, password);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
