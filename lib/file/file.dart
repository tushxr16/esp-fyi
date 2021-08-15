import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class FileOperations {
  Future<String> getFileData(String path) async {
    String data = await rootBundle.loadString('assets/data.txt');
    return data;
  }
}

class ShowDiseaseInfo extends StatefulWidget {
  final String diseaseName;
  final FileOperations file = FileOperations();
  ShowDiseaseInfo({required this.diseaseName});
  @override
  _ShowDiseaseInfoState createState() => _ShowDiseaseInfoState();
}

class _ShowDiseaseInfoState extends State<ShowDiseaseInfo> {
  String content = "Hi";
  String filePath = "assets/data.txt";
  @override
  void initState() {
    super.initState();
    widget.file.getFileData(filePath).then((String value) {
      setState(() {
        var a = value.split("#");
        content = a[0].split(":")[1];
      });
    });
  }

  void dataFetch() async {
    String data = await widget.file.getFileData(filePath);
    var eachList = data.split("#");
    for (int i = 0; i < 38; i++) {
      var eachName = eachList[i].split(":");
      if (eachName[0].contains(widget.diseaseName)) {
        setState(() {
          content = eachName[1];
        });
      }
    }
  }

  Widget build(BuildContext context) {
    dataFetch();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var cont0 = "";
    var cont1 = "Error retrieving data";
    try {
      var cont = content.split("@");
      cont0 = cont[0];
      cont1 = cont[1];
    } catch (e) {}
    var isHealthy = widget.diseaseName.split(";")[1];
    return Container(
        height: height * 0.5,
        width: width * 0.8,
        child: isHealthy != "Healthy"
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
                Text(
                  "What caused it?",
                  style:
                      TextStyle(color: Colors.grey[400], fontSize: height / 25),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      '\n$cont0\n',
                      style:
                          TextStyle(color: Colors.white, fontSize: height / 70),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 60,
                ),
                Text(
                  "What is the solution?",
                  style:
                      TextStyle(color: Colors.grey[400], fontSize: height / 25),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      '\n$cont1\n',
                      style:
                          TextStyle(color: Colors.white, fontSize: height / 70),
                    ),
                  ),
                ),
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text(
                      "Your plant looks HEALTHY !!",
                      style: TextStyle(
                          color: Colors.grey[400], fontSize: height / 40),
                    ),
                  ]));
  }
}
