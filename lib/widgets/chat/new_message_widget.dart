import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatefulWidget {

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'created': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['username'],
      'userImage':userData.data()!['image_url'],
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (val){
                  setState(() {
                    _enteredMessage = val;
                  });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
