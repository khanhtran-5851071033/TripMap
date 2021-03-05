import 'package:example/view/shared/util.dart';
import 'package:flutter/material.dart';

import 'package:panorama/panorama.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:example/view/screens/floorplan_screen.dart';

class PanoScreen extends StatefulWidget {
  PanoScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PanoScreenState createState() => _PanoScreenState();
}

class _PanoScreenState extends State<PanoScreen> {
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  double _zoom = 1, animSpeed = 0;
  int _panoId = 0, imageSize = 0;
  List panoImages = [
    [
      Image.asset('assets/cong.jpg'),
      Image.asset('assets/congx2.jpg'),
    ],
    [
      Image.asset('assets/c2.jpg'),
      Image.asset('assets/c2x2.jpg'),
    ],
    [
      Image.asset('assets/ngababaixe.jpg'),
      Image.asset('assets/ngababaixex2.jpg'),
    ],
    [
      Image.asset('assets/nga3sangtao.jpg'),
      Image.asset('assets/nga3sangtaox2.jpg'),
    ],
    [
      Image.asset('assets/saue2.jpg'),
      Image.asset('assets/saue2x2.jpg'),
    ],
    [
      Image.asset('assets/nhaxe.jpg'),
      Image.asset('assets/nhaxex2.jpg'),
    ],
    [
      Image.asset('assets/trcnhaxe.jpg'),
      Image.asset('assets/trcnhaxex2.jpg'),
    ],
    [
      Image.asset('assets/e2.jpg'),
      Image.asset('assets/e2x2.jpg'),
    ],
  ];
  List hotSpot = [
    [
      {"lat": -10.0, "long": 90.0, "id": 1, "name": 'C2', 'type': 'arrow'},
      {"lat": -10.0, "long": 0.0, "id": 2, "name": 'Nga ba', 'type': 'arrow'},
      //Building
      {"lat": 15.0, "long": 75.0, "id": 1, "name": 'C2', 'type': 'image'},
    ],
    [
      {"lat": -10.0, "long": -90.0, "id": 0, "name": 'Cong', 'type': 'arrow'},
      // {"lat": -0.0, "long": 0.0, "id": 2, "name": 'nga ba'},
    ],
    [
      // {"lat": -0.0, "long": 0.0, "id": 0, "name": 'Cong'},
      {"lat": -10.0, "long": 180.0, "id": 0, "name": 'Cong', 'type': 'arrow'},
      {"lat": -10.0, "long": 90.0, "id": 7, "name": 'E2', 'type': 'arrow'},
      {"lat": -10.0, "long": 0.0, "id": 3, "name": '', 'type': 'arrow'},
    ],
    [
      {"lat": -10.0, "long": 180.0, "id": 2, "name": 'Nga ba', 'type': 'arrow'},
      {"lat": -10.0, "long": 90.0, "id": 4, "name": 'sau e2', 'type': 'arrow'},
    ],
    [
      {"lat": -10.0, "long": 90.0, "id": 5, "name": 'Nha xe', 'type': 'arrow'},
      {
        "lat": -10.0,
        "long": -90.0,
        "id": 3,
        "name": 'nga3 sang tao',
        'type': 'arrow'
      },
    ],
    [
      {
        "lat": -10.0,
        "long": 180.0,
        "id": 6,
        "name": 'Truoc nha xe',
        'type': 'arrow'
      },
      {"lat": -10.0, "long": -90.0, "id": 4, "name": 'sau e2', 'type': 'arrow'},
    ],
    [
      {"lat": -10.0, "long": -90.0, "id": 7, "name": 'E2', 'type': 'arrow'},
      {"lat": -10.0, "long": 0.0, "id": 5, "name": 'Nha xe', 'type': 'arrow'},
    ],
    [
      {"lat": -10.0, "long": -90.0, "id": 2, "name": 'Nga ba', 'type': 'arrow'},
      {
        "lat": -10.0,
        "long": 90.0,
        "id": 6,
        "name": 'Truoc nha xe',
        'type': 'arrow'
      },
    ]
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton(int id, String text, String type) {
    return Transform(
      transform: type == 'arrow'
          ? (Matrix4.identity()..rotateX(150))
          : (Matrix4.identity()..rotateX(0)),
      child: AvatarGlow(
        glowColor:
            type == 'arrow' ? Colors.amber.withOpacity(0.8) : Util.myColor,
        endRadius: 50.0,
        duration: Duration(milliseconds: 1500),
        repeat: true,
        // showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: InkWell(
          child: type == 'arrow'
              ? Container(
                  padding: EdgeInsets.all(2),
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(
                    color: type == 'arrow'
                        ? Colors.amber.withOpacity(0.5)
                        : Util.myColor,
                    shape:
                        type == 'arrow' ? BoxShape.circle : BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Icon(
                            Icons.double_arrow,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 100,
                    color: Util.myColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          style: TextStyle(color: Colors.white),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Image.asset(
                          'assets/utc.png',
                          fit: BoxFit.fitWidth,
                          // height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
          onTap: () {
            setState(() {
              animSpeed = 0;
              imageSize = 0;
              _panoId = id;
              _zoom = 1;
            });
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                imageSize = 1;
              });
            });
          },
        ),
      ),
    );
  }

  Widget panoramaWidget(int id) {
    var pano = Panorama(
      animSpeed: animSpeed,
      zoom: _zoom,
      sensitivity: 1.5,
      sensorControl: SensorControl.Orientation,
      onViewChanged: onViewChanged,
      onLongPressStart: (longitude, latitude, tilt) {
        if (animSpeed == 1) {
          setState(() {
            animSpeed = 0;
          });
        } else {
          setState(() {
            animSpeed = 1;
          });
        }
      },
      child: panoImages[id][imageSize],
      latitude: 0,
      longitude: 0,
      hotspots: List.generate(hotSpot[id].length, (index) {
        return Hotspot(
          latitude: hotSpot[id][index]['lat'],
          longitude: hotSpot[id][index]['long'],
          width: 120,
          height: 100,
          widget: hotspotButton(hotSpot[id][index]['id'],
              hotSpot[id][index]['name'], hotSpot[id][index]['type']),
        );
      }),
    );
    return pano;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          imageSize = 1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget panorama;

    // switch (_panoId % panoImages.length) {
    //   case 0:
    //     panorama = panoramaWidget(1);
    //     break;
    //   case 2:
    //     panorama = panoramaWidget(2);
    //     break;
    //   default:
    //     panorama = panoramaWidget(0);
    // }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Stack(
        children: [
          panoramaWidget(_panoId),
          Positioned(
              left: 0,
              bottom: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white54,
                    child: Hero(
                        tag: 'mapUtc2',
                        child: Image.asset('assets/Utc2Map1.png'))),
              ))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   mini: true,
      //   onPressed: () {
      //     ImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      //       setState(() {
      //         panoImages.add(Image.file(value));
      //         _panoId = panoImages.length - 1;
      //       });
      //     });
      //   },
      //   child: Icon(Icons.panorama),
      // ),
    );
  }
}
