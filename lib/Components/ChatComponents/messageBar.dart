// ignore_for_file: camel_case_types, use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
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
    return Material(
      color: Colors.grey[200],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: true,
                  controller: messageEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => submitMessgage(),
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
