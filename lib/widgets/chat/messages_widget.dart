import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fun_chat_app/widgets/chat/message_bubble_widget.dart';
class MessagesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget _showProgresIndicator(){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx,  futureSnapshot) {
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return _showProgresIndicator();
          }
          return StreamBuilder(stream: Firestore.instance.collection('chat')
              .orderBy('created', descending: true)
              .snapshots(), builder: (ctx, chatSnapshot){
            if(chatSnapshot.connectionState == ConnectionState.waiting){
              return _showProgresIndicator();
            }
            var documents = chatSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(10),
                child: MessageBubbleWidget(
                    documents[index]['userName'],
                    documents[index]['text'],
                    documents[index]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(documents[index].documentID),
                ),
              ),
            );
          });
        }
    );
  }
}
