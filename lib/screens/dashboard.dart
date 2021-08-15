import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:espfyi/circles/humid.dart';
import 'package:espfyi/circles/moist.dart';
import 'package:espfyi/circles/temp.dart';
import 'package:espfyi/firebase/database.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  final MaterialColor barColor;

  DashBoard({required this.barColor});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var textColor = Colors.pink;
  var fontWeightValuePut = FontWeight.bold;
  var colorRefresh = Colors.grey;
  double valueChoose = 45;
  int a = 0;
  List userDataList = [
    {'Temperature': 0.0, 'Moisture': 0.0, 'Humidity': 0.0},
  ];
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

  var barColor = Colors.yellow;
  Future<void> showInfo(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Open the Valve ?',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: barColor),
                              onPressed: () async {
                                Uri url = Uri.parse(
                                    "https://androidfirebasecollab-default-rtdb.firebaseio.com/SENSOR/B3eInRAyoiVpZnOQ5V1vWrmbxM13.json");
                                http.patch(url,
                                    body: json.encode({
                                      'WaterSwitch': 1,
                                      'WaterSwitchTrig': valueChoose
                                    }));
                                colorRefresh = Colors.blue;
                                await fetchDataList();
                              },
                              child: Text('Yes')),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: barColor),
                              onPressed: () async {
                                Uri url = Uri.parse(
                                    "https://androidfirebasecollab-default-rtdb.firebaseio.com/SENSOR/B3eInRAyoiVpZnOQ5V1vWrmbxM13.json");
                                http.patch(url,
                                    body: json.encode({'WaterSwitch': 0}));
                                colorRefresh = Colors.grey;
                                await fetchDataList();
                                // print(userDataList[0]);
                              },
                              child: Text('No')),
                        ],
                      )
                    ],
                  ))
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    fetchDataList();
    final height = MediaQuery.of(context).size.height;
    return a == 0
        ? Scaffold(
            backgroundColor: Color(0x00000000),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await showInfo(context);
              },
              child: Icon(
                Icons.waterfall_chart,
                color: Colors.grey[100],
              ),
              backgroundColor: Color(0x44000000),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: height / 100),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Color(0x11000000),
                      padding: EdgeInsets.all(10),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                          color: Colors.grey[350],
                          fontWeight: FontWeight.w800,
                          fontSize: 32),
                    ),
                  ),
                  SizedBox(height: height / 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Temperature',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: height / 50,
                                  fontWeight: fontWeightValuePut),
                            ),
                            Text(''),
                            TemperatureCircle(
                                tempV: userDataList[0]['Temperature']),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Humidity',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: height / 50,
                                  fontWeight: fontWeightValuePut),
                            ),
                            Text(''),
                            HumidCircle(humidV: userDataList[0]['Humidity']),
                          ],
                        ),
                      ]),
                  Text(''),
                  Text(
                    'Moisture',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: height / 50,
                        fontWeight: fontWeightValuePut),
                  ),
                  Text(''),
                  MoistCircle(moistV: userDataList[0]['Moisture']),
                  SizedBox(
                    height: height / 100,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton.icon(
                          onPressed: () async {
                            dynamic got = await DataBase().getUserData();
                            userDataList = [
                              {
                                'Temperature': got[1],
                                'Moisture': got[2],
                                'Humidity': got[0]
                              },
                            ];
                            setState(() {
                              a = 1;
                              a = 0;
                            });
                          },
                          label: Text(
                            'Refresh',
                            style: TextStyle(color: widget.barColor),
                          ),
                          icon: Icon(
                            Icons.refresh_sharp,
                            color: widget.barColor,
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent, elevation: 0),
                            onPressed: () {},
                            child: Icon(
                              Icons.circle,
                              color: colorRefresh,
                            ))
                      ]),
                  (Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("\n"),
                        Text(
                          "Water Level Trigger",
                          style: TextStyle(
                              color: Colors.yellow[400],
                              fontSize: height / 50,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: height / 50,
                        ),
                        DropdownButton<double>(
                          dropdownColor: Colors.black87,
                          menuMaxHeight: height / 5,
                          value: valueChoose,
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.yellow,
                          ),
                          iconSize: height / 50,
                          elevation: 0,
                          style: TextStyle(
                              color: Colors.white, fontSize: height / 60),
                          underline: Container(
                            height: 1,
                            color: Colors.yellowAccent,
                          ),
                          onChanged: (double? newValueD) {
                            setState(() {
                              valueChoose = newValueD!;
                            });
                          },
                          items: <double>[35, 45, 55, 65, 75, 85]
                              .map<DropdownMenuItem<double>>((double value) {
                            return DropdownMenuItem<double>(
                              value: value,
                              child: Text('$value'),
                            );
                          }).toList(),
                        ),
                      ])),
                  SizedBox(height: height/15,),
                  Text(
                    "Water Level Values",
                    style: TextStyle(
                        color: Colors.yellow[400],
                        fontSize: height/30,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "Corn - (50-75)   Wheat - (60-80)  Grapes - (50-60)",
                    style: TextStyle(
                        color: Colors.yellow[400],
                        fontSize: height/50,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        : Container(child: Text('j'));
  }
}
