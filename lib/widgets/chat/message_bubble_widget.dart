import 'package:flutter/material.dart';


class MessageBubbleWidget extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final Key key;
  final String _userName;

  MessageBubbleWidget(this._userName, this._message, this._isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _isMe? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if(!_isMe)
        Icon(Icons.account_box_outlined),
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
                  )
              ),
              Text(
                _message,
                style: TextStyle(
                  color: Theme.of(context).accentTextTheme.title.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
