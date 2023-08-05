// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, deprecated_member_use, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Chat_Room.dart';
import 'package:roomsquad/Screens/chatRoomScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onAuthenticating(Session session) {}
  final myUserId = supabase.auth.currentUser!.id;
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
                        .from('rooms')
                        .stream(primaryKey: ['id'])
                        .order('created_at')
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
                                room,
                              );
                            }),
                      );
                    }),
                Text('Chat Room'),
                FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      final res = await supabase.rpc('create_room').execute();
                      final data = res.data;

                      if (data == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('error')));
                        return;
                      }
                      final room = chatRooms.fromMap(data);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return chatRoomScreen(
                          room: room,
                        );
                      }));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell singleChatBox(BuildContext ctx, String roomName, chatRooms room) {
    return InkWell(
      onTap: () {
        Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
          return chatRoomScreen(room: room);
        }));
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
