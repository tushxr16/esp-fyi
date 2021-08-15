import 'dart:async';

import 'package:espfyi/firebase/regis.dart';
import 'package:espfyi/firebase/login.dart';
import 'package:espfyi/screens/soilinfo.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool logReg = true;
  bool signOut = true;
  void toggleSign() {
    setState(() => logReg = !logReg);
  }

  void toggleLogOut() {
    setState(() => signOut = !signOut);
  }

  @override
  Widget build(BuildContext context) {
    if (signOut == true) {
      if (logReg == false) {
        return Scaffold(
            body: RegisTer(toggleSign: toggleSign, toggleLogOut: toggleLogOut));
      } else {
        return Scaffold(
            body: LogIn(toggleSign: toggleSign, toggleLogOut: toggleLogOut));
      }
    } else {
      Timer(Duration(seconds: 1), () {
        print('Waited 1sec');
      });
      return SoilInfo(toggleLogOut: toggleLogOut);
    }
  }
}
