import 'package:flutter/material.dart';

class WeatherInfo extends StatefulWidget {
  final MaterialColor barColor;
  WeatherInfo({required this.barColor});

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00000000),
        body: SafeArea(
            child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
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
                          'Weather',
                          style: TextStyle(
                              color: widget.barColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 32),
                        ),
                      ),
                      Container(
                          height: 400,
                          width: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "Location",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Allahabad",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "Temperature",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "39.5 C",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "   Rain?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Will rain in an hour. ",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                )));
  }
}
