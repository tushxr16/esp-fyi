import 'package:espfyi/screens/camera.dart';
import 'package:espfyi/screens/info.dart';
import 'package:espfyi/screens/weather.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class FourScreen extends StatefulWidget {
  final Function index;
  FourScreen({required this.index});

  @override
  _FourScreenState createState() => _FourScreenState();
}

class _FourScreenState extends State<FourScreen> {
  get ind => widget.index();

  var barColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    if (ind == 1) {
      barColor = Colors.yellow;
    }
    if (ind == 2) {
      barColor = Colors.blue;
    }
    if (ind == 3) {
      barColor = Colors.purple;
    }
    if (ind == 4) {
      barColor = Colors.pink;
    }
    if (ind == 1) {
      return DashBoard(
        barColor: barColor,
      );
    }
    if (ind == 2) {
      return WeatherInfo(barColor: barColor);
    }
    if (ind == 3) {
      return CropInfo(
          barColor: barColor, valueCrop: 'Apple', valueDisease: 'Disease');
    }
    if (ind == 4) {
      return CameraDetect(barColor: barColor);
    } else {
      return DashBoard(
        barColor: barColor,
      );
    }
  }
}
