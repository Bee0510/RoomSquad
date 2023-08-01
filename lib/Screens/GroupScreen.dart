// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../Constant/constant.dart';

class groupScreen extends StatelessWidget {
  const groupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromRGBO(164, 14, 76, 100),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
          child: Column(
            children: [
              Text('Chat Room'),
              ElevatedButton(
                  onPressed: () async {
                    await supabase.auth.signOut();
                  },
                  child: Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
