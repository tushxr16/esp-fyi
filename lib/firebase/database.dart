import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class DataBase {
  final String? uid;
  DataBase({this.uid});

  final CollectionReference dhtSensor =
      FirebaseFirestore.instance.collection('DHT');
  Future updateUserData(double temp, double humid, double moisture) async {
    return await dhtSensor.doc(uid).set({
      'Temperature': temp,
      'Humidity': humid,
      'Moisture': moisture,
    });
  }

  Future changeUserData(
      double temp, double humid, double moist, String uid) async {
    return await dhtSensor.doc(uid).update({
      'Temperature': temp,
      'Humidity': humid,
      'Moisture': moist,
    });
  }

  Future getUserData() async {
    List ret = [0, 0, 0];
    Uri url = Uri.parse(
        "https://androidfirebasecollab-default-rtdb.firebaseio.com/SENSOR.json");
    await http.get(url).then((value) {
      var dict = (json.decode(value.body));
      print(dict);
      // ret = [
      //   dict['Humidity'],
      //   dict['Temperature'],
      //   dict['Moisture'].toDouble(),
      // ];
      ret = [
        65.31,
        34.31,
        2531.00,
      ];
    });

    return ret;
  }
}
