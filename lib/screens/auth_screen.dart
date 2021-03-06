import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_chat_app/widgets/auth/auth_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
    final _auth = FirebaseAuth.instance;
    final _storage = FirebaseStorage.instance;
    var _isLoading = false;
  void _submitAuthForm (String email, String password, String username, File image, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + 'jpg');

        try{
          await _storage.ref('user_image/' + authResult.user!.uid + '.jpg')
              .putFile(image);

        }on FirebaseException catch (e){
          print(e);
        }

        final url = await _storage.ref('user_image/' + authResult.user!.uid + '.jpg').getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
              'username' : username,
              'email': email,
              'image_url': url,
            });
      }
      setState(() {
        _isLoading = false;
      });
    }on PlatformException catch(error){
      var message = 'An error occurred, please check your credentials!';

      if(error.message != null)
        message = error.message!;
      
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
            content: Text(
            message,
            ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }catch(error){
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: AuthFormWidget(_submitAuthForm, _isLoading),
      ),
    );
  }
}
