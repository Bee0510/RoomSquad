// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, deprecated_member_use, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:roomsquad/Models/Chat_Room.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Home_Models.dart';

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

  void onAuthenticating(Session session) {}
  final myUserId = supabase.auth.currentUser!.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: true,
        toolbarOpacity: 1,
        backgroundColor: Color.fromRGBO(20, 30, 41, 1),
        actions: [
          createRoomButton(),
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () async {
                await supabase.auth.signOut();
                Navigator.of(context).pushReplacementNamed('loginScreen');
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Color(0xFF00E5FF), // Bright Teal
                //     Color(0xFF8000FF), // Vibrant Purple
                //   ],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                // ),
                color: Color.fromRGBO(39, 52, 67, 100),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: SafeArea(
              child: Column(
                children: [
                  StreamBuilder<List<chatRooms>>(
                      stream: supabase
                          .from('rooms')
                          .stream(primaryKey: ['id'])
                          .order('created_at')
                          .execute()
                          .map(
                              (event) => event.map(chatRooms.fromMap).toList()),
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
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: rooms.length,
                              itemBuilder: (content, index) {
                                final room = rooms[index];

                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: singleChatBox(content, room.groupName,
                                      room, 'No message yet'),
                                );
                              }),
                        );
                      }),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
