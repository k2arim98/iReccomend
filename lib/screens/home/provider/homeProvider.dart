import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';

class HomeProvider extends ChangeNotifier {
  List categoryL = [];
  HomeProvider() {
   
    categoryL = data;
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
