import 'dart:ui';
import 'package:espfyi/firebase/database.dart';
import 'package:espfyi/firebase/login.dart';
import 'package:espfyi/screens/four.dart';
import 'package:flutter/material.dart';

class SoilInfo extends StatefulWidget {
  final Function toggleLogOut;
  SoilInfo({required this.toggleLogOut});

  @override
  _SoilInfoState createState() => _SoilInfoState();
}

class _SoilInfoState extends State<SoilInfo> {
  final Authenticate _auth = Authenticate();
  var textColor = Colors.pink;
  var fontWeightValuePut = FontWeight.bold;
  var colorRefresh = Colors.grey;
  List userDataList = [
    {'Temperature': 0.0, 'Moisture': 0.0, 'Humidity': 0.0},
  ];
  bool dashRefresh = false;
  void toggleDash() {
    setState(() => dashRefresh = !dashRefresh);
  }

  @override
  void initState() {
    super.initState();
    fetchDataList();
  }

  Future<Null> reFresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  fetchDataList() async {
    dynamic got = await DataBase().getUserData();
    print(got);
    if (got == null) {
      print("Didn't got data");
    } else {
      setState(() {
        userDataList = [
          {'Temperature': got[1], 'Moisture': got[2], 'Humidity': got[0]},
        ];
      });
    }
    return got;
  }

  upDataList(double temp, double humid, double moist, String uid) async {
    await DataBase().changeUserData(temp, humid, moist, uid);
  }

  int _selectedIndex = 0;
  int indi = 0;
  int check = 1;
  var img = Image.asset("assets/images/portait.jpeg").image;
  var fit =BoxFit.fill;
  void _onItemTapped(int index) {
    setState(() {
      check = 0;
      if (index == 0) {
        indi = index + 1;
        img = Image.asset("assets/images/portait.jpeg").image;
        fit = BoxFit.fill;
      }
      if (index == 1) {
        indi = index + 1;
        img = Image.asset("assets/images/weathe.jpg").image;
        fit = BoxFit.fill;
      }
      if (index == 2) {
        indi = index + 1;
        img = Image.asset("assets/images/corn.jpg").image;
        fit =BoxFit.fill;
      }
      if (index == 3) {
        indi = index + 1;
        img = Image.asset("assets/images/leaf.jpg").image;
        fit = BoxFit.fitHeight;
      }
      _selectedIndex = index;
    });
  }

  int togglePage() {
    return indi;
  }

  @override
  Widget build(BuildContext context) {
    if (check == 1) {
      indi = 0;
    }
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0x22000000),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_circle_rounded),
              label: 'Weather',
              backgroundColor: Color(0x22000000),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: 'Info-krop',
              backgroundColor: Color(0x22000000),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Camera',
              backgroundColor: Color(0x22000000),
            ),
          ],
          currentIndex: _selectedIndex,elevation: 0,showSelectedLabels: false,
          selectedItemColor: Colors.grey[100],
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Color(0x22000000),
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          backgroundColor: Color(0x00000000),
          elevation: 0,
          toolbarHeight: 50,
          title: Text(
            'ESP-fyi',
            style: TextStyle(color: Colors.grey[400]),
          ),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
                widget.toggleLogOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.grey[400],
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.grey[400]),
              ),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: img,
              fit: fit,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken),
            )),
            child: SafeArea(child: FourScreen(index: togglePage))));
  }
}
