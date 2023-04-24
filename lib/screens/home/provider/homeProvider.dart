import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';

class HomeProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading = true;
  late String nrml = "";
  List categoryL = [];
  HomeProvider() {
    getData();
  }
  getData() {
    log("get data");
    firestore.collection("data").snapshots().listen((event) {
      log(event.docs[0].data()["rating"]);
      categoryL = event.docs;
      loading = false;
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
