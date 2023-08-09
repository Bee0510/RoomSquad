// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, dead_code, no_leading_underscores_for_local_identifiers, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomsquad/Constant/constant.dart';

class dialogueBox extends StatefulWidget {
  dialogueBox({required this.roomId});
  final String roomId;

  @override
  State<dialogueBox> createState() => _dialogueBoxState();
}

class _dialogueBoxState extends State<dialogueBox> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    final _newRoomName = TextEditingController();
    return SimpleDialog(
      backgroundColor: Colors.black87,
      children: <Widget>[
        Center(
          child: Container(
            height: 160,
            width: 400,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _newRoomName,
                  decoration: TextField_decor.copyWith(
                      hintText: 'New Room Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
                SizedBox(height: 15),
                FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    setState(() {
                      isSelected = !isSelected;
                    });
                    final res = await supabase
                        .from('rooms')
                        .update({'name': _newRoomName.text})
                        .eq('id', widget.roomId)
                        .execute();
                    Navigator.of(context).pop();
                  },
                  label: isSelected
                      ? Text(
                          'Save',
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: Colors.white),
                        )
                      : Icon(Icons.airplane_ticket),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class inviteBox extends StatefulWidget {
  const inviteBox({super.key, required this.roomId});
  final String roomId;

  @override
  State<inviteBox> createState() => _inviteBoxState();
}

class _inviteBoxState extends State<inviteBox> {
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    final _newRoomMember = TextEditingController();
    return SimpleDialog(
      backgroundColor: Colors.black87,
      children: <Widget>[
        Center(
          child: Container(
            height: 160,
            width: 400,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _newRoomMember,
                  decoration: TextField_decor.copyWith(
                      hintText: "Member's username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
                SizedBox(height: 15),
                FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    setState(() {
                      isSelected = !isSelected;
                    });
                    final res = await supabase
                        .from('profiles')
                        .select()
                        .eq('username', _newRoomMember.text)
                        .single()
                        .execute();
                    if (res == null) {
                      print('Error fetching profile data: ${res}');
                    } else {
                      final data = res.data;
                      print('Fetched profile data: $data');
                    }
                    final data = res.data;
                    print(res);
                    final insertres =
                        await supabase.from('room_participants').insert({
                      'room_id': widget.roomId,
                      'profile_id': data['id'],
                    }).execute();

                    Navigator.of(context).pop();
                  },
                  label: isSelected
                      ? Text(
                          'Add',
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: Colors.white),
                        )
                      : Icon(Icons.airplane_ticket),
                ),
              ],
            ),
          ),
        )
      ],
    );
    ;
  }
}
