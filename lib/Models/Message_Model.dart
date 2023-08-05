import 'package:flutter/material.dart';

class Message {
  Message({
    required this.id,
    required this.profileId,
    required this.content,
    required this.createdAt,
    required this.roomId,
  });
  final String id;
  final String profileId;
  final String content;

  final DateTime createdAt;
  final String roomId;

  Message.fromMap(
    Map<String, dynamic> map,
  )   : id = map['id'],
        profileId = map['profile_id'],
        content = map['content'],
        createdAt = DateTime.parse(map['created_at']),
        roomId = map['room_id'];
}
