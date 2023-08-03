// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Message_Model.dart';
import 'package:roomsquad/Models/Profile_Model.dart';

class chatBubble extends StatelessWidget {
  const chatBubble({
    required this.message,
    required this.profile,
  });
  final Message message;
  final Profiles? profile;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      if (!message.isMine)
        CircleAvatar(
          child: profile == null
              ? loader
              : Text(
                  profile!.username.substring(0, 2),
                ),
        ),
      const SizedBox(width: 12),
      Flexible(
          child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
            color: message.isMine ? Colors.red : Colors.yellow,
            borderRadius: BorderRadius.circular(8)),
        child: Text(message.content),
      ))
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
