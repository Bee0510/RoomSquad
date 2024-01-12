// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:roomsquad/Screens/HomeScreen/HomeScreen.dart';
// import 'package:roomsquad/Screens/ProfileScreen.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  List<Map<String, Object>> _tabList = [];
  @override
  void initState() {
    _tabList = [
      {'Page': homeScreen(), 'Title': "Home"},
      // {'Page': profileScreen(), 'Title': "Me"},

      // {'Page': About_Page(), 'Title': "About"}
    ];
    super.initState();
  }

  bool selected = false;

  int selectPage = 0;
  void togglePage(int page) {
    setState(() {
      selectPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabList[selectPage]['Page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        backgroundColor: Colors.black,
        currentIndex: selectPage,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: togglePage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          // BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Groups'),
        ],
      ),
    );
  }
}
