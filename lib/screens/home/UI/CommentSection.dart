// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/data/data.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

class TestMe extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
  late HomeProvider providerFalse;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
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
          )
      ],
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
        child: CommentBox(
          //userImage: CommentBox.commentImageParser(imageURLorPath: ""),
          child: commentChild(providerFalse.commentsL),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              SentimentResult s =
                  await Sentiment.analysis(commentController.text, emoji: true);
              SentimentResult tags = await Sentiment.analysis(
                  commentController.text,
                  customLang: customLang); //hashtags analysis
              log(s.toString());
              log(s.words.all.length.toString());
              //checking if it works
              log(tags.toString());
              log(tags.words.all.length.toString());
              FirebaseFirestore.instance
                  .collection("data")
                  .doc(providerFalse.detailPage["uid"])
                  .collection("comments")
                  .add({
                "userName": providerFalse.userData["nom"] +
                    providerFalse.userData["prenom"],
                "content": commentController.text,
                "score": s.comparative,
                "date": Timestamp.now(),
                "tags": tags.words.good.keys.toList()
              }).then((value) {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(providerFalse.userData["uid"])
                    .collection("comments")
                    .add({
                  "userName": providerFalse.userData["nom"] +
                      providerFalse.userData["prenom"],
                  "content": commentController.text,
                  "date": Timestamp.now()
                });

                /*
                FirebaseFirestore.instance
                    .collection("data")
                    .doc(providerFalse.detailPage["uid"])
                    //updating the hashtag table ({
                  //"tags": tags.words.good.keys.toList()
              //  }); */
              }).then((value) {
                commentController.clear();
              });
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.blue.shade600,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
