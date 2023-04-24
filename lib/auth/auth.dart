// @dart=2.9
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user.uid,
      );

  // GET UID
  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    final res = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
          log("this is"+result.toString());
        })
        .onError((error, stackTrace) {
          log(error.toString());
        });
  }

  Future<String> creatUserwithEmail(
      String email, String password, BuildContext context) async {
    final res = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) {
          log("this is"+result.toString());
        })
        .onError((error, stackTrace) {
          log(error.toString());
        });
  }


  // Sign Out
  signOut(BuildContext context) async {
    return await _firebaseAuth.signOut();
  }

  // Create Anonymous User
  Future singInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

}
