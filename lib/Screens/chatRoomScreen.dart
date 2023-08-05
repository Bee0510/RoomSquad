// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, deprecated_member_use, unnecessary_cast, unused_field, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roomsquad/Components/ChatComponents/chatBubble.dart';
import 'package:roomsquad/Components/ChatComponents/messageBar.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Chat_Room.dart';
import 'package:roomsquad/Models/Message_Model.dart';
import 'package:roomsquad/Models/Profile_Model.dart';

class chatRoomScreen extends StatefulWidget {
  const chatRoomScreen({
    required this.room,
  });
  final chatRooms room;
  @override
  State<chatRoomScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatRoomScreen> {
  List<Message>? _messages;

  final Map<String, Profiles> profileCache = {};

  StreamSubscription<List<Message>>? messagesRiver;

  @override
  void initState() {
    messagesRiver = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', widget.room.id)
        .order('created_at')
        .execute()
        .map((maps) => maps.map(Message.fromMap).toList())
        .listen((messages) {
          setState(() {
            _messages = messages;
          });
          for (final message in messages) {
            loadProfileCache(message.profileId);
          }
        });
    super.initState();
  }

  Future<void> loadProfileCache(String profileId) async {
    if (profileCache.containsKey(profileId)) {
      return;
    }
    final res = await supabase
        .from('profiles')
        .select()
        .eq('id', profileId)
        .single()
        .execute();
    final data = res.data;

    if (data != null) {
      setState(() {
        profileCache[profileId] = Profiles.fromMap(data);
      });
    }
  }

  Widget messageList() {
    if (_messages == null) {
      return Center(
        child: Text(_messages.toString()),
      );
    }
    if (_messages!.isEmpty) {
      return Center(
        child: Text('No Conversation Yet'),
      );
    }
    final userId = supabase.auth.currentUser!.id;
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        reverse: true,
        itemCount: _messages!.length,
        itemBuilder: (context, index) {
          final Message = _messages![index];
          return Align(
            alignment: userId == Message.profileId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: chatBubble(
                    message: Message,
                    profileCache: profileCache,
                    userId: userId)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.room.groupName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: messageList(),
          ),
          messageBar(
            roomId: widget.room.id,
          ),
        ],
      )),
    );
  }
}
