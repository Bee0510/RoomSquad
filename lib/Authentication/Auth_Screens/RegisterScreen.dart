// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Constant/constant.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _formkey = GlobalKey<FormState>();
  String Email = '';
  String password = '';
  String username = '';
  String error = '';

  Future<void> _register() async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      await supabase.auth.signUp(
          email: Email, password: password, data: {'username': username});
      Navigator.of(context)
          .pushNamedAndRemoveUntil('chatScreen', (route) => false);
    } on AuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 195, 154, 100),
      body: Form(
          key: _formkey,
          child: Center(
            child: Container(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the email' : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextField_decor.copyWith(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onChanged: (value) {
                        setState(() {
                          Email = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final isValid =
                            RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(value);
                        if (!isValid) {
                          return '3-24 long with alphanumeric or underscore';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextField_decor.copyWith(
                          hintText: 'username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) =>
                          value!.length < 6 ? 'Enter a valid password' : null,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: TextField_decor.copyWith(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: loading ? null : _register,
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(height: 8),
                        Divider(thickness: 2, color: Colors.grey[850]),
                        TextButton(
                            onPressed: () => {
                                  Navigator.of(context).pushNamed('loginScreen')
                                },
                            child: Text(
                              'Already have an account',
                              style: TextStyle(),
                            )),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(error, style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
