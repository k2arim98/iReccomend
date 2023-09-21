// @dart=2.9
// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:developer';
import 'dart:ffi';

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
  List PopularPost = [];
  List tagsL = [];
  List categorySave = [];
  List mostVL = [];
  List commentsL = [];
  List favoriteL = [];
  List userComments = [];
  Double Ratings;

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
    double indice_Dice;
    List v = data["tags"];
    log("first entry");
    getuserTags(detailPage["uid"]);
    log("this is the tags :" + getuserTags(detailPage["uid"]).toString());
    getCommentData(detailPage["uid"], detailPage["views"]);
    log(v.length.toString());
    for (var j = 0; j < categorySave.length; j++) {
      log("second entry");
      var nums = 0;
      List lts = categorySave[j]["tags"];
      if (categorySave[j]["name"] == data["name"]) {
      } else {
        log("third entry");
        v.forEach((element) {
          log("forth entry");
          for (var i = 0; i < lts.length; i++) {
            log("fifth entry");
            if (element == lts[i]) {
              log("six entry");
              nums++;
            }
          }
        });
        indice_Dice = (2 * nums) / detailPage.length;
        log("the similarity is equal to =" + nums.toString());
        if (indice_Dice > 0.4) {
          firestore
              .collection("users")
              .doc(user.uid)
              .collection("similair")
              .doc(categorySave[j]["name"])
              .set(categorySave[j].data());
        }
      }

      log("done");
    }
    notifyListeners();
  }

  getSetnimentScore() {
    log("this is testing score" + Sentiment.analysis('i hate you').toString());
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
      favoriteL = event.docs.toList();
      List Favoris = favoriteL.toList().toSet().toList();

      log("this is my range " + favoriteL.length.toString());
    });
  }

  /*getRatings() {
    firestore.collection("data").where("rating").get().then((value) {
      Ratings = double.parse(value.docs.toString()) as Double;

      log("this is views" + Ratings.toString());
      notifyListeners();
    });
  }*/

  getUserComments() {
    firestore.collection("users").snapshots().listen((event) {
      userComments = event.docs;
    });
  }

  getMostViewd() {
    log("hey do u see me");
    firestore
        .collection("data")
        .where("views", isGreaterThan: 5)
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
        .where("liked", isGreaterThan: 5)
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
        .doc(user.uid)
        .collection("similair")
        .snapshots()
        .listen((value) {
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
        .where("overallS", isGreaterThan: 0.2)
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

/* _ */
  getuserTags(String uid) {
    List tags = [];
    firestore
        .collection("data")
        .doc(uid)
        .collection("comments")
        .where("tags")
        .snapshots()
        .listen((event) {
      tagsL = event.docs;
      for (int i = 0; i < tagsL.length; i++) {
        tags = tags + tagsL[i].data()["tags"];
      }
      log("hiii" + tags.toString());
      List tagList = tags.toList().toSet().toList();
      FirebaseFirestore.instance
          .collection("data")
          .doc(uid)
          .update({"tags": tagList});
    });
  }

/*
  setPopularPage(Map<String, dynamic> data) {
    detailPage = data;
    double indice_Dice2;
    List v = data["views"];
    log("first entry");
    log(v.length.toString());
    for (var j = 0; j < categorySave.length; j++) {
      log("second entry");
      var nums = 0;
      List lts = categorySave[j]["views"];
      if (categorySave[j]["name"] == data["name"]) {
      } else {
        v.forEach((element) {
          for (var i = 0; i < lts.length; i++) {
            if (element == lts[i]) {
              nums++;
            }
          }
        });
        indice_Dice2 = (2 * nums) / detailPage.length;
        log("the similarity is equal to =" + indice_Dice2.toString());
        if (indice_Dice2 > 0) {
          firestore
              .collection("users")
              .doc(user.uid)
              .collection("SimilairPosts")
              .doc(categorySave[j]["name"])
              .set(categorySave[j].data());
        }
      }

      log("done");
    }
    notifyListeners();
  }

  getsimilairPosts() {
    log("hey do u see me");
    firestore
        .collection("users")
        .doc(user.uid)
        .collection("SimilairPosts")
        .snapshots()
        .listen((value) {
      categoryL = value.docs;

      notifyListeners();
    });
  }*/
}
