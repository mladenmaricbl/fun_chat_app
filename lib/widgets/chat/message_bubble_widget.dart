import 'package:flutter/material.dart';


class MessageBubbleWidget extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final String _userImage;
  final Key key;
  final String _userName;

  MessageBubbleWidget(this._userName, this._message, this._userImage,  this._isMe, {required this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _isMe? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if(!_isMe)
        CircleAvatar(
          backgroundImage: NetworkImage(_userImage),
        ),
        Container(
          decoration: BoxDecoration(
            color: _isMe? Colors.deepOrange : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft:!_isMe? Radius.circular(0) : Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: _isMe? Radius.circular(0) : Radius.circular(12),
            )
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment:_isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if(!_isMe)
              Text(
                  _userName,
                 style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
              ),
              Text(
                _message,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
