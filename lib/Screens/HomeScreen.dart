// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

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
            ],
          ),
        ),
      ),
    );
  }
}
