// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:roomsquad/Screens/GroupScreen.dart';
import 'package:roomsquad/Screens/HomeScreen.dart';
import 'package:roomsquad/Screens/ProfileScreen.dart';

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
      {'Page': groupScreen(), 'Title': "Squad"},
      {'Page': profileScreen(), 'Title': "Me"},

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
      // appBar: App_Bar(context, _tabList[selectPage]['Title'].toString()),
      body: _tabList[selectPage]['Page'] as Widget,
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Colors.black,
        initialSelection: 1,
        inactiveIconColor: Colors.white,
        activeIconColor: Colors.white,
        textColor: Colors.black,
        circleColor: Colors.black,
        tabs: [
          TabData(
            iconData: Icons.home_outlined,
            title: 'Home',
          ),
          TabData(
            iconData: Icons.group,
            title: 'Squad',
          ),
          TabData(
            iconData: Icons.person,
            title: 'Me',
          ),
        ],
        onTabChangedListener: togglePage,
      ),
    );
  }
}
