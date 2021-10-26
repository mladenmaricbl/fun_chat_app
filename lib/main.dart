import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_chat_app/screens/auth_screen.dart';
import 'package:fun_chat_app/screens/chat_screen.dart';
import 'package:fun_chat_app/screens/splash_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String _title = 'FunChat app';
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      // FlutterFire init!
       future: _initialization,
       builder: (context, appSnapshot){
         return MaterialApp(
           title: _title,
           theme: ThemeData(
             primarySwatch: Colors.blue,
             backgroundColor: Colors.blue,
             accentColor: Colors.red,
             accentColorBrightness: Brightness.dark,
             buttonTheme: ButtonTheme.of(context).copyWith(
                 buttonColor: Colors.blue,
                 textTheme: ButtonTextTheme.primary,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
             ),
           ),
           home: appSnapshot.connectionState != ConnectionState.done ? SplashScreen()
             :
         StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot) {
           if(userSnapshot.hasData)
             return ChatScreen();

           return AuthScreen();
         }),
         );
    });
  }
}