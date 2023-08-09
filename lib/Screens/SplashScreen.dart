// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_element, camel_case_types, unused_import

import 'package:flutter/material.dart';
import 'package:roomsquad/Constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  Future<void> _authDecider() async {
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('registerScreen', (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('homeScreen', (route) => false);
    }
  }

  @override
  void initState() {
    _authDecider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
