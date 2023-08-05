// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:roomsquad/Authentication/Auth_Screens/LoginScreen.dart';
import 'package:roomsquad/Authentication/Auth_Screens/RegisterScreen.dart';
import 'package:roomsquad/Screens/BottomNavigator.dart';
import 'package:roomsquad/Screens/SplashScreen.dart';
import 'package:roomsquad/Screens/chatRoomScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Constant/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://aidmawbyfgmvdmnmvjuv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpZG1hd2J5ZmdtdmRtbm12anV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEwOTM3ODksImV4cCI6MjAwNjY2OTc4OX0.K91KyYkDNOgpNPsNUKY5XzWOMKb999DyS7gGIfZiEbU',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'registerScreen': (context) => registerScreen(),
        'loginScreen': (context) => loginScreen(),
        'chatScreen': (context) => chatScreen(),
      },
      home: const splashScreen(),
    );
  }
}
