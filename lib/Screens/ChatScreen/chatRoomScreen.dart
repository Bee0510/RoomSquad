// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, deprecated_member_use, unnecessary_cast, unused_field, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roomsquad/Components/ChatComponents/chatBubble.dart';
import 'package:roomsquad/Components/ChatComponents/messageBar.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Chat_Room.dart';
import 'package:roomsquad/Models/Message_Model.dart';
import 'package:roomsquad/Models/Profile_Model.dart';
import 'package:roomsquad/Screens/ChatScreen/Chat_Models.dart';

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
  String img =
      'https://universosamsung.com/wp-content/uploads/2020/12/Whatsapp-Wallpaper-112-768x1365-1.jpg';

  final Map<String, Profiles> profileCache = {};

  StreamSubscription<List<Message>>? messagesRiver;

  @override
  void initState() {
    message_stream();
    super.initState();
  }

  StreamSubscription<List<Message>> message_stream() {
    return messagesRiver = supabase
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Color.fromRGBO(20, 30, 41, 1),
        title: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return dialogueBox(roomId: widget.room.id);
                });
          },
          child: Text(
            widget.room.groupName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return inviteBox(
                        roomId: widget.room.id,
                      );
                    });
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('chatRoomDetails');
              },
              icon: Icon(Icons.view_column)),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              Expanded(
                child: messageList(),
              ),
              messageBar(
                roomId: widget.room.id,
              ),
            ],
          ),
        ),
      ),
    );
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
}
