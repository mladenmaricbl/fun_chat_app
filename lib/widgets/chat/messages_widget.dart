import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_chat_app/widgets/chat/message_bubble_widget.dart';
class MessagesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    Widget _showProgresIndicator(){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('chat')
        .orderBy('created', descending: true)
        .snapshots(), builder: (ctx, chatSnapshot){
      if(chatSnapshot.connectionState == ConnectionState.waiting){
        return _showProgresIndicator();
      }
      var documents = chatSnapshot.data.docs;
      return ListView.builder(
        reverse: true,
        itemCount: documents.length,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(10),
          child: MessageBubbleWidget(
            documents[index].data()['userName'],
            documents[index].data()['text'],
            documents[index].data()['userId'] == user.uid,
            key: ValueKey(documents[index].id),
          ),
        ),
      );
    });
  }
}
