// ignore_for_file: empty_constructor_bodies
// @dart=2.9
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  AppState() {
    log("this is wheere appstate is first called");
    deletesimilair();
  }

  deletesimilair()async {
    log("this is similair fsadasdasdasdasdasda");
    var collection =  firestore.collection("users").doc(user.uid).collection("similair");
var snapshots = await collection.get();
for (var doc in snapshots.docs) {
  await doc.reference.delete();
}


  }
}
