// @dart=2.9
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

class HomeProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  bool loading = true;
  Map<String, dynamic> detailPage;
  Map<String, dynamic> userData;
  String nrml = "";
  List categoryL = [];
  List categorySave = [];
  List mostVL = [];
  List commentsL = [];
  List favoriteL = [];
  List userComments = [];
  HomeProvider() {
    getData();
    getUserData();
    
  }
  getData() {
    log("get data");

    firestore.collection("data").snapshots().listen((event) {
      log(event.docs[0].data()["rating"].toString());
      categoryL = event.docs;
      categorySave = event.docs;
      log("im i here?" + categoryL[0]["tags"].toString());
      loading = false;
      notifyListeners();
    });
  }

  getUserData() {
    log("get users");
    getSetnimentScore();
    firestore.collection("users").doc(user.uid).snapshots().listen((event) {
      log("this is my name " + event.data()["nom"]);
      userData = event.data();
      getFavorites();
      getUserComments();

      notifyListeners();
    });
  }

  setDetailPage(Map<String, dynamic> data) {
    detailPage = data;
    List v = data["tags"];
    log("first entry");
    getCommentData(detailPage["uid"], detailPage["views"]);
    log(v.length.toString());
    for (var j = 0; j < categorySave.length; j++) {
      log("second entry");
      var nums=0;
      List lts = categorySave[j]["tags"];
      if (categorySave[j]["name"] == data["name"]) {
        log("bro idk");
      } else {
        log("third entry");
        v.forEach((element) {
          log("forth entry");
          for (var i = 0; i < lts.length; i++) {
            log("fifth entry");
            if (element==lts[i]) {
              log("six entry");
              nums++;
            }
          }
        });

        if (nums>0) {
             firestore
        .collection("users")
        .doc(user.uid)
        .collection("similair").doc(categorySave[j]["name"]).set(categorySave[j].data());
        }
      }

      log("vsdfsdfsdfsdfsd");
    }

 
    notifyListeners();
  }

  getSetnimentScore() {
    log("this is ftesting score" + Sentiment.analysis('i hate you').toString());
  }

  getCommentData(String uid, coun) {
    double allComments = 0;
    firestore
        .collection("data")
        .doc(uid)
        .collection("comments")
        .snapshots()
        .listen((event) {
      commentsL = event.docs;
      log(commentsL.length.toString());
      for (int i = 0; i < commentsL.length; i++) {
        allComments = allComments + commentsL[i].data()["score"];
      }
      allComments = allComments / commentsL.length;
      firestore
          .collection("data")
          .doc(uid)
          .update({"overallS": allComments, "views": coun + 1});

      log("this is all commetns" + allComments.toString());
      notifyListeners();
    });
  }

  getCategoryData(String type) {
    log("this is clicked");
    categoryL = categorySave;
    List categoryLL = [];
    log("this is " + categoryL.length.toString());

    for (var i = 0; i < categoryL.length; i++) {
      log("catego" + categoryL[i].data()["category"]);
      if (categoryL[i].data()["category"] == type) {
        log("it is equal$i");
        categoryLL.add(categoryL[i]);
      }
    }
    categoryL = categoryLL;
    firestore.collection("users").doc(user.uid).update({
      "lastClicked": type,
    });
    notifyListeners();
  }

  getFavorites() {
    firestore
        .collection("users")
        .doc(user.uid)
        .collection("favorite")
        .snapshots()
        .listen((event) {
      favoriteL = event.docs;
      log("this is my range " + favoriteL.length.toString());
    });
  }

  getUserComments() {
    firestore
        .collection("users")
        .doc(user.uid)
        .collection("comments")
        .snapshots()
        .listen((event) {
      userComments = event.docs;
    });
  }

  getMostViewd() {
    log("hey do u see me");
    firestore
        .collection("data")
        .where("views", isGreaterThan: 1)
        .orderBy("views", descending: true)
        .get()
        .then((value) {
      categoryL = value.docs;

      log("this is views" + value.docs[0].data()["views"].toString());
      notifyListeners();
    });
  }

  getMostliked() {
    log("hey do u see me");
    firestore
        .collection("data")
        .where("liked", isGreaterThan: 1)
        .orderBy("liked")
        .get()
        .then((value) {
      categoryL = value.docs;

      log("this is views" + value.docs[0].data()["views"].toString());
      notifyListeners();
    });
  }
 getsimilair() {
    log("hey do u see me");
    firestore
        .collection("users")
        .doc(user.uid).collection("similair")
        .snapshots().listen((value) {
      categoryL = value.docs;

      
      notifyListeners();
    });
  }
  geteRecommanded() {
    log("hey recommanded u see me");
    categoryL = [];
    notifyListeners();
    firestore
        .collection("data")
        .where("overallS", isGreaterThan: 0.1)
        .orderBy("overallS", descending: true)
        .where("category", isEqualTo: userData["lastClicked"])
        .where("liked")
        .orderBy("liked", descending: true)
        .get()
        .then((value) {
      log("this is here ");

      categoryL = value.docs;

      log("this is data " + value.docs[0].data()["name"].toString());
      notifyListeners();
    });
  }
}
