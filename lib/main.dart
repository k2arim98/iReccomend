
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:irecommend/routings/routing.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:irecommend/screens/login/UI/loginPage.dart';
import 'package:irecommend/screens/login/provider/loginProvider.dart';
import 'package:irecommend/providers/appState.dart';
import 'package:irecommend/screens/registration/provider/registrationProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => IntroProvider(),
        // ),
             ChangeNotifierProvider(
          create: (context) => RegistrationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppState(),
        ),
          ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => ChangePasswordProvider(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: LoginPage(),
      ),
    ),
  );
}
