// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

class Another2 extends StatefulWidget {
  @override
  _Another2State createState() => _Another2State();
}

class _Another2State extends State<Another2> {
  late HomeProvider providerFalse;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'message': 'Nice place',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'message': 'Overrated',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'message': 'I do not like it',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'message': 'i like the service',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return ListView.builder(
      itemCount: data.length,
      
      itemBuilder: (context, i) {
      return   Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i].data()['pic'])),
                ),
              ),
              title: Text(
                data[i].data()['userName'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i].data()['content']),
              trailing: Text("s", style: TextStyle(fontSize: 10)),
            ),
          );
     
    },
     
    );
  }

  @override
  Widget build(BuildContext context) {
    providerFalse = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Visitors Comments",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        child: commentChild(providerFalse.userComments) ),
    );
  }
}
