import 'dart:async';
import 'package:espfyi/firebase/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'database.dart';


class LogIn extends StatefulWidget {
  final Function toggleSign;
  final Function toggleLogOut;
  LogIn({required this.toggleSign, required this.toggleLogOut});
  @override
  _LogInState createState() => _LogInState();
}

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FUser _userFromFirebase(User? user) {
    return FUser(uid: user!.uid);
  }

  Stream<FUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    try {
      UserCredential response = await _auth.signInAnonymously();
      User? user = response.user;
      await DataBase(uid: user!.uid).updateUserData(25.0, 60.0, 2000.0);
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future signIn(String email, String pass) async {
    try {
      UserCredential response =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User user = response.user!;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user!;

      await DataBase(uid: user.uid).updateUserData(25.0, 30.0, 3000.0);

      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

class _LogInState extends State<LogIn> {
  final userName = TextEditingController();
  final password = TextEditingController();
  final img = Image.asset("assets/images/main page.jpg").image;
  MaterialColor themeColor = Colors.deepOrange;
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final databaseRef = FirebaseDatabase.instance.reference();
  final Authenticate _auth = Authenticate();
  String errorString = "";
  void func(String errorMsg) {
    setState(() {
      errorString = errorMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(height.toString() + " " + width.toString());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0x00000000),
          elevation: 0,
          title: Text(
            'ESP-fyi',
            style: TextStyle(color: Colors.white70),
          ),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () {
                  widget.toggleSign();
                },
                icon:
                    Icon(Icons.app_registration_outlined, color: Colors.white),
                label: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: img,
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.15), BlendMode.darken),
          )),
          child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(height / 45),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x22000000),
                              ),
                              child: TextField(
                                cursorColor: Colors.lightGreen,
                                decoration: InputDecoration(
                                  labelText: "  Email ID ",
                                  labelStyle: TextStyle(
                                      color: Colors.green[50],
                                      fontWeight: FontWeight.w800,
                                      fontSize: height / 45),
                                ),
                                controller: userName,
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                maxLength: 30,
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: height / 40,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(height / 45),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x22000000),
                              ),
                              child: TextField(
                                obscureText: true,
                                cursorColor: Colors.lightGreen,
                                decoration: InputDecoration(
                                  labelText: " Password ",
                                  labelStyle: TextStyle(
                                      color: Colors.green[50],
                                      fontWeight: FontWeight.w800,
                                      fontSize: height / 45),
                                ),
                                controller: password,
                                keyboardType: TextInputType.number,
                                maxLength: 8,
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: height / 40,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Text(
                          errorString,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height / 40,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 30.0),
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0x22000000),
                                    ),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    onPressed: () async {
                                      dynamic res = await _auth.signIn(
                                          userName.text, password.text);
                                      if (res == null) {
                                        func("Invalid username or password.");
                                      } else {
                                        widget.toggleLogOut();
                                        print(res.uid);
                                      }

                                      return res;
                                    }),
                              ]),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0x22000000),
                            ),
                            child: Text(
                              "Sign In Anonymously",
                              style: TextStyle(color: Colors.white70),
                            ),
                            onPressed: () async {
                              dynamic res = await _auth.signInAnon();
                              if (res == null) {
                                func("Failed to sign in anonymously.");
                              } else {
                                widget.toggleLogOut();
                                print(res.uid);
                              }

                              return res;
                            })
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}
