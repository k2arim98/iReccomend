// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// @dart=2.9
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irecommend/auth/auth.dart';
import 'package:irecommend/utility/constant.dart';
import 'package:irecommend/data/data.dart';
import 'package:irecommend/main.dart';
import 'package:irecommend/providers/appState.dart';
import 'package:irecommend/screens/home/Models/model.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:irecommend/screens/login/UI/loginPage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String picked = "All";
  HomeProvider providerTrue;
  HomeProvider providerFalse;
  AppState appState;
  static const _padding = 24.0;
  static const _spacing = 10.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<HomeProvider>(context, listen: true);
    providerFalse = Provider.of<HomeProvider>(context);
    appState = Provider.of<AppState>(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 15, 29, 161),
                image: DecorationImage(
                  image: AssetImage("assets/images/cover.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Divider(
              color: Colors.black38.withOpacity(0.8),
              endIndent: 20,
              indent: 20,
              height: 4,
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("About"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text("Contact"),
              onTap: () {},
            ),
            TextButton(
              onPressed: () {
                AuthService().signOut(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (ctx) => LoginPage()));
              },
              child: Text("sign out"),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              header(),
              const SizedBox(height: 24),
              searchBar(),
              const SizedBox(height: 36),
              categories(),
              const SizedBox(height: 16),
              const Model(
                padding: _padding,
                spacing: _spacing,
              ),
              const SizedBox(height: 20),
              modelCategories(),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.ac_unit,
            color: kSecondaryColor,
            size: 24,
          ),
          Icon(
            Icons.ac_unit,
            color: kSecondaryColor,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Looks Like',
                  style: TextStyle(
                    color: kSecondaryColor.withOpacity(0.6),
                    fontSize: 22,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'you need help',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              log("button pressed");
              _scaffoldKey.currentState.openEndDrawer();
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 26,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Color.fromARGB(255, 26, 23, 65)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.search,
              color: Style.white,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              ' Search ... ',
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget categories() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            'Explore Jobs',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _padding),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                for (final category in categoryList)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          picked = category;
                        });
                        if (category == "Most Viewd") {
                          providerFalse.getMostViewd();
                        } else if (category == "All") {
                          log("this i clicked");
                          providerFalse.getData();
                        } else if (category == "Most Liked") {
                          log("this i clicked");
                          providerFalse.getMostliked();
                        } else if (category == "Recommended") {
                          log("this i clicked");
                          providerFalse.geteRecommanded();
                        } else if (category == "For You") {
                          providerFalse.getsimilair();
                        }
                      },
                      child: Text(
                        category,
                        style: TextStyle(
                          color: picked == category
                              ? Color.fromARGB(255, 16, 15, 30)
                              : kSecondaryColor.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget modelCategories() {
    return SizedBox(
      // color: Colors.red,
      width: double.infinity,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: Text(
              'Categories',
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  ...List.generate(
                      data_2.length,
                      (i) => GestureDetector(
                            onTap: () async {
                              log(data_2[i]["name"]);
                              await providerFalse
                                  .getCategoryData(data_2[i]["name"]);
                              log(providerFalse.categoryL.length.toString());
                              setState(() {
                                colorIndex = i;
                              });
                            },
                            child: Container(
                              // width: 80,
                              // color: Colors.green,
                              margin: const EdgeInsets.only(left: 35),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        data_2[i]["index"] == colorIndex
                                            ? const Color.fromARGB(
                                                255, 77, 118, 243)
                                            : const Color(0xffeaeaea),
                                    radius: 26,
                                    backgroundImage:
                                        AssetImage(data_2[i]["image"]),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    data_2[i]["name"],
                                    style: TextStyle(
                                      color: kSecondaryColor.withOpacity(0.8),
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
