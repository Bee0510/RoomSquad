// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_declarations, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';

class newGrpDiaBox extends StatefulWidget {
  const newGrpDiaBox({super.key});

  @override
  State<newGrpDiaBox> createState() => _newGrpDiaBoxState();
}

class _newGrpDiaBoxState extends State<newGrpDiaBox> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final groupName = TextEditingController();
    final roomCode = TextEditingController();
    return SimpleDialog(
        title: Center(child: const Text('Invite a user')),
        backgroundColor: Color.fromRGBO(214, 246, 221, 100),
        children: [
          Center(
            child: Container(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter new group name' : null,
                      controller: groupName,
                      keyboardType: TextInputType.name,
                      decoration: TextField_decor.copyWith(
                          hintText: 'New group name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => value!.length < 6
                          ? 'Room code should be of 6 digit'
                          : null,
                      controller: roomCode,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      decoration: TextField_decor.copyWith(
                          hintText: 'Room Code',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () async {
                              final data = await supabase
                                  .from('chat_rooms')
                                  .insert({
                                'name': groupName.text,
                                'room_code': roomCode.text
                              });
                            },
                            child: Text(
                              'Create',
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(height: 8),
                        Divider(thickness: 2, color: Colors.grey[850]),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Join a team',
                              style: TextStyle(),
                            )),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ]);
  }
}
