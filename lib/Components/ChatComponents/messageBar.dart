// ignore_for_file: camel_case_types, use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class messageBar extends StatefulWidget {
  const messageBar({required this.roomId});
  final String roomId;

  @override
  State<messageBar> createState() => _messageBarState();
}

class _messageBarState extends State<messageBar> {
  late final TextEditingController messageEditingController;
  bool isTyped = true;
  void submitMessgage() async {
    final text = messageEditingController.text;
    final myUserId = supabase.auth.currentUser!.id;
    if (text.isEmpty) {
      return;
    }
    messageEditingController.clear();
    try {
      await supabase.from('messages').insert({
        'room_id': widget.roomId,
        'profile_id': myUserId,
        'content': text,
      }).execute();
    } catch (e) {
      print(e.toString() + 'fhwbh');
    }
  }

  @override
  void initState() {
    messageEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8, bottom: 4),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    controller: messageEditingController,
                    style:
                        GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(20, 30, 41, 1),
                        hintText: "Message",
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 18, color: Colors.grey[700]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)))),
              ),
              TextButton(
                onPressed: () {
                  submitMessgage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
