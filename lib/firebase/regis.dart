import 'package:espfyi/firebase/login.dart';
import 'package:flutter/material.dart';

class RegisTer extends StatefulWidget {
  final Function toggleSign;
  final Function toggleLogOut;
  RegisTer({required this.toggleSign, required this.toggleLogOut});

  @override
  _RegisTerState createState() => _RegisTerState();
}

class _RegisTerState extends State<RegisTer> {
  final Authenticate _auth = Authenticate();
  final userNameR = TextEditingController();
  final passwordR = TextEditingController();
  final numberR = TextEditingController();
  final locationR = TextEditingController();
  MaterialColor themeColor = Colors.orange;
  String errorString = "";
  void func(String errorMsg) {
    setState(() {
      errorString = errorMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0x00000000),elevation: 0,
          title: Text('ESP-fyi',style: TextStyle(color: Colors.white70),),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () {
                  widget.toggleSign();
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: Image.asset("assets/images/main page.jpg").image,
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.15), BlendMode.darken),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x22000000),
                    ),
                    child: TextField(
                      cursorColor: Colors.lightGreen,
                      decoration: InputDecoration(
                        labelText: " Email ID ",
                        labelStyle: TextStyle(
                            color: Colors.green[50],
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                      controller: userNameR,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 30,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  )), //Username
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x22000000),
                    ),
                    child: TextField(
                      obscureText: true,
                      cursorColor: Colors.lightGreen,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: " Password ",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: Colors.green[50],
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                      controller: passwordR,
                      maxLength: 8,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  )), //Password
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x22000000),
                    ),
                    child: TextField(
                      obscureText: true,
                      cursorColor: Colors.lightGreen,
                      decoration: InputDecoration(
                        labelText: " Number ",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: Colors.green[50],
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                      controller: numberR,
                      maxLength: 10,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  )), //Number
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x22000000),
                    ),
                    child: TextField(
                      obscureText: true,
                      cursorColor: Colors.lightGreen,
                      decoration: InputDecoration(
                        labelText: " Location ",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: Colors.green[50],
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                      controller: locationR,
                      maxLength: 20,
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Text(
                errorString,
                style: TextStyle(
                    color: Colors.white60,
                    backgroundColor: Color(0x22000000),
                    fontSize: 20),
              ), //Location
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0x22000000),
                          ),
                          child: Text("Register",style: TextStyle(color: Colors.white70),),
                          onPressed: () async {
                            func("");
                            dynamic res =
                                await _auth.registerWithEmailAndPassword(
                                    userNameR.text, passwordR.text);
                            if (res == null) {
                              func("Error Registering");
                            } else {
                              widget.toggleLogOut();
                              print(res.uid);
                            }
                            return res;
                          }),
                    ]),
              ),
            ],
          ),
        ));
  }
}
