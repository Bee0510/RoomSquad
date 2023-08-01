// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromRGBO(193, 102, 107, 100),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
          child: Column(
            children: [
              Text('Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
