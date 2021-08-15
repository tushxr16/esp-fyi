import 'package:espfyi/file/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropInfo extends StatefulWidget {
  final MaterialColor barColor;
  final String valueCrop;
  final String valueDisease;
  CropInfo(
      {required this.barColor,
      required this.valueCrop,
      required this.valueDisease});

  @override
  _CropInfoState createState() => _CropInfoState();
}

class _CropInfoState extends State<CropInfo> {
  List itemList = [
    [
      'Apple',
      5,
      [
        'Disease',
        'Scab',
        'Black_Rot',
        'Cedar',
        'Healthy',
      ],
    ],
    [
      'Blueberry',
      2,
      [
        'Disease',
        'Healthy',
      ],
    ],
    [
      'Cherry',
      3,
      [
        'Disease',
        'Powder_Mildew',
        'Healthy',
      ],
    ],
    [
      'Corn',
      5,
      [
        'Disease',
        'Gray_Leaf_Spot',
        'Rust',
        'Northern_Leaf_Blight',
        'Healthy',
      ],
    ],
    [
      'Grape',
      5,
      [
        'Disease',
        'Black_Rot',
        'Black_Measles',
        'Leaf_Blight',
        'Healthy',
      ],
    ],
    [
      'Orange',
      2,
      [
        'Disease',
        'Citrus_Greening',
      ],
    ],
    [
      'Peach',
      3,
      [
        'Disease',
        'Bacterial_Spot',
        'Healthy',
      ],
    ],
    [
      'Pepper',
      3,
      [
        'Disease',
        'Bacterial_Spot',
        'Healthy',
      ],
    ],
    [
      'Potato',
      4,
      [
        'Disease',
        'Early_Blight',
        'Late_Blight',
        'Healthy',
      ],
    ],
    [
      'Raspberry',
      2,
      [
        'Disease',
        'Healthy',
      ],
    ],
    [
      'Soybean',
      2,
      [
        'Disease',
        'Healthy',
      ],
    ],
    [
      'Squash',
      2,
      [
        'Disease',
        'Powder_Mildew',
      ],
    ],
    [
      'Strawberry',
      3,
      [
        'Disease',
        'Leaf_Scorch',
        'Healthy',
      ],
    ],
    [
      'Tomato',
      11,
      [
        'Disease',
        'Bacterial_Spot',
        'Early_Blight',
        'Late_Blight',
        'Leaf_Mold',
        'Septoria_Leaf',
        'Spider_Mites',
        'Target_Spot',
        'Yellow_Leaf',
        'Mosaic_Virus',
        'Healthy',
      ],
    ],
  ];
  int getInt(String? newValue) {
    for (int i = 0; i < 14; i++) {
      if (newValue == itemList[i][0]) {
        return i;
      }
    }
    return 0;
  }

  late String valueChooseCrop;
  late int indexCrop;
  late String valueChooseDisease;
  bool diseaseShow = true;
  @override
  void initState() {
    super.initState();
    valueChooseCrop = widget.valueCrop;
    indexCrop = getInt(valueChooseCrop);
    valueChooseDisease = widget.valueDisease;
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0x00000000),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: height / 80,
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
                  'Crop Information',
                  style: TextStyle(
                      color: widget.barColor,
                      fontWeight: FontWeight.w800,
                      fontSize: height / 20),
                ),
              ),
              SizedBox(
                height: height / 80,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                DropdownButton<String>(
                  dropdownColor: Colors.black,
                  menuMaxHeight: 200,
                  hint: Text('Crop'),
                  value: valueChooseCrop,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.purple,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.white, fontSize: height/60),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      indexCrop = getInt(newValue);
                      valueChooseDisease = itemList[indexCrop][2][0];
                      valueChooseCrop = newValue!;
                    });
                  },
                  items: <String>[
                    itemList[0][0],
                    itemList[1][0],
                    itemList[2][0],
                    itemList[3][0],
                    itemList[4][0],
                    itemList[5][0],
                    itemList[6][0],
                    itemList[7][0],
                    itemList[8][0],
                    itemList[9][0],
                    itemList[10][0],
                    itemList[11][0],
                    itemList[12][0],
                    itemList[13][0],
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: valueChooseDisease,
                    menuMaxHeight: 200,
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.purple,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.white, fontSize: height/60),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValueD) {
                      setState(() {
                        valueChooseDisease = newValueD!;
                        diseaseShow = !diseaseShow;
                        diseaseShow = !diseaseShow;
                      });
                    },
                    items: itemList[indexCrop][1] >= 5
                        ? itemList[indexCrop][1] == 11
                            ? <String>[
                                itemList[indexCrop][2][0],
                                itemList[indexCrop][2][1],
                                itemList[indexCrop][2][2],
                                itemList[indexCrop][2][3],
                                itemList[indexCrop][2][4],
                                itemList[indexCrop][2][5],
                                itemList[indexCrop][2][6],
                                itemList[indexCrop][2][7],
                                itemList[indexCrop][2][8],
                                itemList[indexCrop][2][9],
                                itemList[indexCrop][2][10],
                              ].map<DropdownMenuItem<String>>((String valueD) {
                                return DropdownMenuItem<String>(
                                  value: valueD,
                                  child: Text(valueD),
                                );
                              }).toList()
                            : <String>[
                                itemList[indexCrop][2][0],
                                itemList[indexCrop][2][1],
                                itemList[indexCrop][2][2],
                                itemList[indexCrop][2][3],
                                itemList[indexCrop][2][4],
                              ].map<DropdownMenuItem<String>>((String valueD) {
                                return DropdownMenuItem<String>(
                                  value: valueD,
                                  child: Text(valueD),
                                );
                              }).toList()
                        : <String>[
                            itemList[indexCrop][2][0],
                            itemList[indexCrop][2][1],
                          ].map<DropdownMenuItem<String>>((String valueD) {
                            return DropdownMenuItem<String>(
                              value: valueD,
                              child: Text(valueD),
                            );
                          }).toList()),
              ]),
              SizedBox(
                height: height / 25,
              ),
              valueChooseDisease != 'Disease'
                  ? ShowDiseaseInfo(
                      diseaseName: valueChooseCrop + ";" + valueChooseDisease)
                  : Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          SizedBox(
                            height: height / 4,
                          ),
                          Text(
                            'Search for the plants disease\t\t\t\t\t\t\nfrom menu.',
                            style: TextStyle(
                                fontSize: height / 40, color: Colors.white),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        ]))
            ],
          ),
        ));
  }
}
