// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:roomsquad/Components/ChatComponents/chatBubble.dart';
import 'package:roomsquad/Components/ChatComponents/messageBar.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Chat_Room.dart';
import 'package:roomsquad/Models/Message_Model.dart';
import 'package:roomsquad/Models/Profile_Model.dart';

class chatRoomScreen extends StatefulWidget {
  const chatRoomScreen({super.key});

  @override
  State<chatRoomScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatRoomScreen> {
  late final Stream<List<Message>> messageRiver;
  final Map<String, Profiles> profileCache = {};
  late final Stream<List<chatRooms>> chatRoomDetails;

  @override
  void initState() {
    final myUserId = supabase.auth.currentUser!.id;
    messageRiver = supabase.from('messages').stream(primaryKey: ['id']).map(
      (event) => event
          .map((map) => Message.fromMap(map: map, myUserId: myUserId))
          .toList(),
    );

    super.initState();
  }

  Future<void> loadProfileCache(String profileId) async {
    if (profileCache[profileId] != null) {
      return;
    }
    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profiles.fromMap(data);
    setState(() {
      profileCache[profileId] = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('grp name')),
        body: StreamBuilder<List<Message>>(
          stream: messageRiver,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final messages = snapshot.data;
              return Column(
                children: <Widget>[
                  Expanded(
                      child: messages!.isEmpty
                          ? const Center(child: Text('No conversation'))
                          : ListView.builder(
                              // reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (content, index) {
                                final message = messages[index];
                                loadProfileCache(message.profileId);
                                return chatBubble(
                                    message: message,
                                    profile: profileCache[message.profileId]);
                              })),
                  messadeBar(),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
