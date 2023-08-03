// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:roomsquad/Authentication/Auth_Screens/LoginScreen.dart';
import 'package:roomsquad/Authentication/Auth_Screens/RegisterScreen.dart';
import 'package:roomsquad/Screens/BottomNavigator.dart';
import 'package:roomsquad/Screens/SplashScreen.dart';
import 'package:roomsquad/Screens/chatRoomScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://yziuumoenranivjqogph.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6aXV1bW9lbnJhbml2anFvZ3BoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA3NDQ5NzksImV4cCI6MjAwNjMyMDk3OX0.0ZoxZGmWz-Q_r8Eqwhd4RIoRbw0Rd-5Wq0KfFVTRADo',
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
        'chatRoomScreen': (context) => chatRoomScreen(),
      },
      home: const splashScreen(),
    );
  }
}
