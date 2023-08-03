// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Constant/newGrpDialogueBox.dart';
import 'package:roomsquad/Models/Chat_Room.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromRGBO(164, 14, 76, 100),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                StreamBuilder<List<chatRooms>>(
                    stream: supabase
                        .from('chat_rooms')
                        .stream(primaryKey: ['id'])
                        .execute()
                        .map((event) => event.map(chatRooms.fromMap).toList()),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return loader;
                      }
                      final rooms = snapshot.data;
                      if (rooms!.isEmpty) {
                        return const Center(
                          child: Text('Create a room'),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: rooms.length,
                            itemBuilder: (content, index) {
                              final room = rooms[index];
                              return singleChatBox(
                                content,
                                room.groupName,
                              );
                            }),
                      );
                    }),
                Text('Chat Room'),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return newGrpDiaBox();
                          });
                    },
                    child: Text('Create new Squad'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell singleChatBox(BuildContext ctx, String roomName) {
    return InkWell(
      onTap: () {
        Navigator.of(ctx).pushNamed('chatRoomScreen');
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(color: Colors.yellow),
        child: Center(child: Text(roomName)),
      ),
    );
  }
}
