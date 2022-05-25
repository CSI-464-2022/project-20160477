//import 'dart:html';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:as1/providers/tab_provider.dart';
import 'package:as1/providers/user_provider.dart';
import 'package:as1/providers/app_provider.dart';

import 'package:as1/screens/home.dart';
import 'package:as1/screens/login.dart';
import 'package:as1/utils.dart';

// import ''
const p_color = Color(0xFF219652);

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserData()),
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => TabIndex()),
    ], child: MyApp()));

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // final Future<FirebaseApp> _initFb = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: 'ABeeZee',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: p_color,
            // secondary: const Colors.yellow.shade700,
          ),
        ),
        home: Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Home();
              } else if (snapshot.hasError) {
                print("An Error has occured");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Login();
            },
          ),
        )
        //  FutureBuilder(
        //   future: _initFb,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       print("An Error has occured");
        //     }
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       print(snapshot);
        //       return Home();
        //     }
        //     return CircularProgressIndicator();
        //   },
        // ),
        );
  }
}
