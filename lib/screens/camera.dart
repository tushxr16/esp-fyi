import 'dart:io';
import 'package:espfyi/screens/info.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CameraDetect extends StatefulWidget {
  final MaterialColor barColor;
  CameraDetect({required this.barColor});

  @override
  _CameraDetectState createState() => _CameraDetectState();
}

class _CameraDetectState extends State<CameraDetect> {
  final ImagePicker _picker = ImagePicker();
  String imgPath = "";
  String vC = 'Apple';
  String vD = 'Disease';
  int cI = 0;
  String info = "";
  int selectPage = 0;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    var res = await Tflite.loadModel(
        model: "assets/output.tflite", labels: "assets/labels.txt");
    print("Result: $res");
  }

  List _predict = [];
  String _predicted = "";
  double _predictPer = 0.0;

  final nameChange = {
    'Apple__Apple_scab': 'Apple Scab',
    'Apple_Black_rot': 'Apple Black_Rot',
    'Apple_Cedar_apple_rust': 'Apple Cedar',
    'Apple_healthy': 'Apple Healthy',
    'Blueberry_healthy': 'Blueberry Healthy',
    'Cherry(including_sour)__Powdery_mildew': 'Cherry Powdery_Mildew',
    'Cherry(including_sour)__healthy': 'Cherry Healthy',
    'Corn(maize)__Cercospora_leaf_spot Gray_leaf_spot': 'Corn Gray_Leaf_Spot',
    'Corn(maize)__Common_rust': 'Corn Rust',
    'Corn_(maize)__Northern_Leaf_Blight': 'Corn Northern_Leaf_Blight',
    'Corn(maize)__healthy': 'Corn Healthy',
    'Grape_Black_rot': 'Grape Black_Rot',
    'Grape_Esca(Black_Measles)': 'Grape Black_Measles',
    'Grape__Leaf_blight(Isariopsis_Leaf_Spot)': 'Grape Leaf_Blight',
    'Grape__healthy': 'Grape Healthy',
    'Orange_Haunglongbing(Citrus_greening)': 'Orange Citrus_Greening',
    'Peach__Bacterial_spot': 'Peach Bacterial_Spot',
    'Peach_healthy': 'Peach Healthy',
    'Pepper,_bell_Bacterial_spot': 'Pepper Bacterial_Spot',
    'Pepper,_bell_healthy': 'Pepper Healthy',
    'Potato_Early_blight': 'Potato Early_Blight',
    'Potato_Late_blight': 'Potato Late Blight',
    'Potato_healthy': 'Potato Healthy',
    'Raspberry_healthy': 'Raspberry Healthy',
    'Soybean_healthy': 'Soybean Healthy',
    'Squash_Powdery_mildew': 'Squash Powdery_Mildew',
    'Strawberry_Leaf_scorch': 'Strawberry Leaf_Scorch',
    'Strawberry_healthy': 'Strawberry Healthy',
    'Tomato_Bacterial_spot': 'Tomato Bacterial_Spot',
    'Tomato_Early_blight': 'Tomato Early_Blight',
    'Tomato_Late_blight': 'Tomato Late_Blight',
    'Tomato_Leaf_Mold': 'Tomato Leaf_Mold',
    'Tomato_Septoria_leaf_spot': 'Tomato Septoria_Leaf',
    'Tomato_Spider_mites Two-spotted_spider_mite': 'Tomato Spider_Mites',
    'Tomato_Target_Spot': 'Tomato Target_Spot',
    'Tomato_Tomato_Yellow_Leaf_Curl_Virus': 'Tomato Yellow_Leaf',
    'Tomato_Tomato_mosaic_virus': 'Tomato Mosaic_Virus',
    'Tomato__healthy': 'Tomato Healthy',
  };
  applyModel(File file) async {
    var result = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    print(result);
    setState(() {
      _predict = result!;
      _predicted = _predict[0]['label'];
      _predictPer = _predict[0]['confidence'];
      info = nameChange[_predicted]!;
      var a = info.split(' ');
      vC = a[0];
      vD = a[1];
      info = info + " with a\nconfidence of " + _predictPer.toStringAsFixed(4);
    });
  }

  Widget build(BuildContext context) {
    return selectPage == 0
        ? Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Color(0x00000000),
            body: Container(
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
                              'Detect Disease',
                              style: TextStyle(
                                  color: widget.barColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 32),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final img = await _picker.getImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 256,
                                  maxWidth: 256);
                              if (img != null) {
                                File? croppedFile =
                                    await ImageCropper.cropImage(
                                  sourcePath: img.path,
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.square,
                                  ],
                                  androidUiSettings: AndroidUiSettings(
                                      toolbarTitle: 'Cropper',
                                      toolbarColor: Colors.deepOrange,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                          CropAspectRatioPreset.original,
                                      lockAspectRatio: false),
                                );
                                imgPath = croppedFile!.path;
                                setState(() {
                                  applyModel(croppedFile);
                                });
                              }
                            },
                            child: Text(
                              'Open Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final img = await _picker.getImage(
                                  source: ImageSource.camera,
                                  maxHeight: 256,
                                  maxWidth: 256);
                              if (img != null) {
                                File? croppedFile =
                                    await ImageCropper.cropImage(
                                  sourcePath: img.path,
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.square,
                                  ],
                                  androidUiSettings: AndroidUiSettings(
                                      toolbarTitle: 'Cropper',
                                      toolbarColor: Colors.deepOrange,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                          CropAspectRatioPreset.original,
                                      lockAspectRatio: false),
                                );
                                imgPath = croppedFile!.path;
                                setState(() {
                                  applyModel(croppedFile);
                                });
                              }
                            },
                            child: Text(
                              'Take Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          imgPath != ""
                              ? Container(
                                  width: 300,
                                  height: 300,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 200,
                                          width: 200,
                                          child: Image.file(
                                            File(imgPath),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black),
                                          onPressed: () {
                                            setState(() {
                                              selectPage = 1;
                                            });
                                          },
                                          child: Text(
                                            info,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ]))
                              : Container(
                                  child: Center(
                                      child: Text(
                                  'No File',
                                  style: TextStyle(color: Colors.white),
                                ))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: widget.barColor),
                                onPressed: () {
                                  setState(() {
                                    imgPath = "";
                                  });
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.refresh_rounded,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )))
        : Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 140,
                  width: MediaQuery.of(context).size.width,
                  child: CropInfo(
                    barColor: widget.barColor,
                    valueCrop: vC,
                    valueDisease: vD,
                  ),
                )
              ]));
  }
}
