// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Message_Model.dart';
import 'package:roomsquad/Models/Profile_Model.dart';

class chatBubble extends StatelessWidget {
  const chatBubble(
      {required this.message,
      required this.profileCache,
      required this.userId});
  final String userId;
  final Message message;
  final Map<String, Profiles> profileCache;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(4),
      color: userId == message.id ? Colors.grey[300] : Colors.blue[200],
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              profileCache[message.profileId]?.username ?? 'Loading....',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            Text(
              message.content,
              style: const TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
