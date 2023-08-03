// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class messadeBar extends StatefulWidget {
  const messadeBar({super.key});

  @override
  State<messadeBar> createState() => _messadeBarState();
}

class _messadeBarState extends State<messadeBar> {
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
        'profile_id': myUserId,
        'content': text,
      }).select();
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
