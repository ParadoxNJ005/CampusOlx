import 'package:campus_olx/services/DatabaseFunctions.dart';
import 'package:campus_olx/services/authFunctions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenScreen extends StatefulWidget {
  const AuthenScreen({super.key});

  @override
  State<AuthenScreen> createState() => _AuthenScreenState();
}

class _AuthenScreenState extends State<AuthenScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String email = '';
  String password = '';
  String oname = '';
  String orollno = '';
  String onumber = '';
  String ohostel = '';
  String oroom = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email/Pass Auth', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 94, 6, 94),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: !isLogin ? 500 : 350,
            width: 350,
            margin: EdgeInsets.only(top: 150),
            child: Card(
              elevation: 4,
              color: Color.fromARGB(255, 253, 250, 250),
              child: Form(
                key: _formkey,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !isLogin
                          ? Column(
                              children: [
                                TextFormField(
                                  key: ValueKey('name'),
                                  decoration: InputDecoration(
                                      hintText: "Enter Username"),
                                  validator: (value) {
                                    if (value.toString().length < 3) {
                                      return 'Username is so small';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      oname = value!;
                                    });
                                  },
                                ),
                                TextFormField(
                                  key: ValueKey('phone'),
                                  decoration: InputDecoration(
                                      hintText: "Enter Contact number"),
                                  validator: (value) {
                                    if (value.toString().length < 10) {
                                      return 'invalid number';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      onumber = value!;
                                    });
                                  },
                                ),
                                TextFormField(
                                  key: ValueKey('rollno'),
                                  decoration:
                                      InputDecoration(hintText: "Enter Rollno"),
                                  validator: (value) {
                                    if (value.toString().length < 10) {
                                      return 'Invalid number';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      orollno = value!;
                                    });
                                  },
                                ),
                                TextFormField(
                                  key: ValueKey('hostel'),
                                  decoration: InputDecoration(
                                      hintText: "Enter hostel name"),
                                  validator: (value) {
                                    if (value.toString().length < 3) {
                                      return 'Invalid hostel';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      ohostel = value!;
                                    });
                                  },
                                ),
                                TextFormField(
                                  key: ValueKey('room no.'),
                                  decoration: InputDecoration(
                                      hintText: "Enter room no."),
                                  validator: (value) {
                                    if (value.toString().length < 3) {
                                      return 'Invalid room no.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      oroom = value!;
                                    });
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      TextFormField(
                        key: ValueKey('Email'),
                        decoration: InputDecoration(hintText: "Enter Email"),
                        validator: (value) {
                          if (!(value.toString().contains("@"))) {
                            return 'Invalid Email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value!;
                          });
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        key: ValueKey('Password'),
                        decoration: InputDecoration(hintText: "Enter Password"),
                        validator: (value) {
                          if (value.toString().length < 6) {
                            return 'Password is so small';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                if (isLogin) {
                                  signin(email, password);
                                } else {
                                  signup(email, password, oname, onumber,
                                      orollno, ohostel, oroom);
                                }
                              }
                            },
                            child: !isLogin
                                ? Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    "Log In",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 107, 179, 235)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: !isLogin
                              ? Text("Already Signed Up? Login")
                              : Text("Not Have an Account? Signup"))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
