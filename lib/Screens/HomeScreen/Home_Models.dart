// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, deprecated_member_use, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import '../../Models/Chat_Room.dart';
import '../ChatScreen/chatRoomScreen.dart';

InkWell singleChatBox(
    BuildContext ctx, String roomName, chatRooms room, String lastMessage) {
  String img =
      'https://tse1.mm.bing.net/th?id=OIP.tsR2JIVIrROEl5H0isyvXgHaEK&pid=Api&rs=1&c=1&qlt=95&w=172&h=96';
  return InkWell(
    onTap: () {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
        return chatRoomScreen(room: room);
      }));
    },
    child: Container(
      width: 800,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 24.4,
              child: InkWell(
                onTap: () {},
                child: Hero(
                  tag: 'Pic',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(img),
                    radius: 24,
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  style: GoogleFonts.roboto(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Text(
                  lastMessage,
                  style: GoogleFonts.roboto(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class createRoomButton extends StatelessWidget {
  const createRoomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 40,
          width: 170,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            child: Center(
              child: Text(
                'Create New',
                style: GoogleFonts.roboto(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () async {
              final res = await supabase.rpc('create_room').execute();
              final data = res.data;

              if (data == null) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('error')));
                return;
              }
              final room = chatRooms.fromMap(data);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return chatRoomScreen(
                  room: room,
                );
              }));
            },
          )),
    );
  }
}
