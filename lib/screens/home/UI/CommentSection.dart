// ignore_for_file: prefer_const_constructors, avoid_print



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class TestMe extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
 late  HomeProvider providerFalse;
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
          userImage: CommentBox.commentImageParser(imageURLorPath: ""),
          child: commentChild(providerFalse.commentsL),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              FirebaseFirestore.instance.collection("data").doc(providerFalse.detailPage["uid"]).collection("comments").add({
                "userName":"anis",
                "content": commentController.text,
                "date":Timestamp.now()
              });
              setState(() {
                var value = {
                  'name': 'New User',
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
              commentController.clear();
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
