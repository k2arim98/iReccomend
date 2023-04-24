
// ignore_for_file: prefer_const_constructors
// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:irecommend/firebase_options.dart';
import 'package:irecommend/routings/routing.dart';
import 'package:irecommend/screens/home/UI/homeScreen.dart';
import 'package:irecommend/screens/home/provider/homeProvider.dart';
import 'package:irecommend/screens/login/UI/loginPage.dart';
import 'package:irecommend/screens/login/provider/loginProvider.dart';
import 'package:irecommend/providers/appState.dart';
import 'package:irecommend/screens/registration/provider/registrationProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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
     
        home: MyWidget(),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
AppState appState;
// Get the firebase user
User firebaseUser = FirebaseAuth.instance.currentUser;
// Define a widget



  @override
  Widget build(BuildContext context) {
    appState= Provider.of<AppState>(context);
    return FutureBuilder<User>(
            future:Future.value(FirebaseAuth.instance.currentUser) ,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                       if (snapshot.hasData){
                           User user = snapshot.data; // this is your user instance
                           /// is because there is user already logged
                           return Routing();
                        }
                         /// other way there is no user logged.
                         return LoginPage();
             }
          );
  }
}

