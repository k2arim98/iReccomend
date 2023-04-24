// @dart=2.9
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';

class HomeProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user=FirebaseAuth.instance.currentUser;
  bool loading = true;
  Map<String, dynamic> detailPage;
   String nrml = "";
  List categoryL = [];
  List commentsL = [];
  HomeProvider() {
    getData();
    getUserData();
  }
  getData() {
    log("get data");
    firestore.collection("data").snapshots().listen((event) {
      log(event.docs[0].data()["rating"].toString());
      categoryL = event.docs;

      log("im i here?");
      loading = false;
      notifyListeners();
    });
  }
getUserData(){
  log("get users");
  firestore.collection("users").doc(user.uid).snapshots().listen((event){
log("this is my name "+event.data()["nom"]);

  });
}
  setDetailPage(Map<String, dynamic> data){
detailPage=data;
getCommentData(detailPage["uid"]);
notifyListeners();
  }
  getCommentData(String uid){
firestore.collection("data").doc(uid).collection("comments").snapshots().listen((event) { 
commentsL=event.docs;
log(commentsL.length.toString());
notifyListeners();
});
  }
  getCategoryData(String type) {
    categoryL = [];

    for (var i = 0; i < data.length; i++) {
      if (data[i]["type"] == type) {
        log("it is equal$i");
        categoryL.add(data[i]);
      }
    }

    notifyListeners();
  }
}
