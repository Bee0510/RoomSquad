// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Constant/constant.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formkey = GlobalKey<FormState>();
  String Email = '';
  String password = '';
  String username = '';
  String error = '';
  bool loading = false;

  Future<void> _signIn() async {
    setState(() {
      loading = true;
    });
    try {
      await supabase.auth.signInWithPassword(password: password, email: Email);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('homeScreen', (route) => false);
    } catch (e) {
      print(e.toString());
    }
  }

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
                            onPressed: loading ? null : _signIn,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(height: 8),
                        Divider(thickness: 2, color: Colors.grey[850]),
                        TextButton(
                            onPressed: () => {
                                  Navigator.of(context)
                                      .pushNamed('registerScreen')
                                },
                            child: Text(
                              'Dont have an account?',
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
