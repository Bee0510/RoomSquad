// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class chatRoomDetails extends StatefulWidget {
  const chatRoomDetails({super.key});

  @override
  State<chatRoomDetails> createState() => _chatRoomDetailsState();
}

class _chatRoomDetailsState extends State<chatRoomDetails> {
  final String img =
      'https://tse1.mm.bing.net/th?id=OIP.tsR2JIVIrROEl5H0isyvXgHaEK&pid=Api&rs=1&c=1&qlt=95&w=172&h=96';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                profileSection1(img: img),
                SizedBox(height: 3),
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(20, 30, 41, 1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class profileSection1 extends StatelessWidget {
  const profileSection1({
    Key? key,
    required this.img,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(color: Color.fromRGBO(20, 30, 41, 1)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
              color: Colors.white,
            ),
          ]),
          CircleAvatar(
            backgroundColor: Color.fromRGBO(9, 17, 26, 1),
            radius: 60,
            backgroundImage: NetworkImage(img),
          ),
          SizedBox(height: 20),
          Text(
            'Group Name',
            style: GoogleFonts.roboto(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.call,
                        color: Color.fromARGB(255, 91, 239, 96),
                        size: 40,
                      )),
                  SizedBox(height: 5),
                  Text(
                    'Group call',
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 91, 239, 96)),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 91, 239, 96),
                        size: 40,
                      )),
                  SizedBox(height: 5),
                  Text(
                    'Search',
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 91, 239, 96)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
