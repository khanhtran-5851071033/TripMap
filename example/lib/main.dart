import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/view/screens/floorplan_screen.dart';
import 'package:example/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FloorPlanModel>(
            create: (context) => FloorPlanModel()),
      ],
      child: MaterialApp(
        title: 'UTC2',
        // theme: ThemeData.dark(),
        //home: MyHomePage(title: 'UTC2'),
        // home: FloorPlanScreen(),
        home: LoginScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      {"lat": -10.0, "long": 90.0, "id": 1, "name": 'C2'},
      {"lat": -10.0, "long": 0.0, "id": 2, "name": 'Nga ba'},
    ],
    [
      {"lat": -10.0, "long": -90.0, "id": 0, "name": 'Cong'},
      // {"lat": -0.0, "long": 0.0, "id": 2, "name": 'nga ba'},
    ],
    [
      // {"lat": -0.0, "long": 0.0, "id": 0, "name": 'Cong'},
      {"lat": -10.0, "long": 180.0, "id": 0, "name": 'Cong'},
      {"lat": -10.0, "long": 90.0, "id": 7, "name": 'E2'},
      {"lat": -10.0, "long": 0.0, "id": 3, "name": ''},
    ],
    [
      {"lat": -10.0, "long": 180.0, "id": 2, "name": 'Nga ba'},
      {"lat": -10.0, "long": 90.0, "id": 4, "name": 'sau e2'},
    ],
    [
      {"lat": -10.0, "long": 90.0, "id": 5, "name": 'Nha xe'},
      {"lat": -10.0, "long": -90.0, "id": 3, "name": 'nga3 sang tao'},
    ],
    [
      {"lat": -10.0, "long": 180.0, "id": 6, "name": 'Truoc nha xe'},
      {"lat": -10.0, "long": -90.0, "id": 4, "name": 'sau e2'},
    ],
    [
      {"lat": -10.0, "long": -90.0, "id": 7, "name": 'E2'},
      {"lat": -10.0, "long": 0.0, "id": 5, "name": 'Nha xe'},
    ],
    [
      {"lat": -10.0, "long": -90.0, "id": 2, "name": 'Nga ba'},
      {"lat": -10.0, "long": 90.0, "id": 6, "name": 'Truoc nha xe'},
    ]
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton(int id, String text) {
    return Transform(
      transform: Matrix4.identity()..rotateX(150),
      child: AvatarGlow(
        glowColor: Colors.yellow[600],
        endRadius: 80.0,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        // showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.all(5),
            width: 80,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Icon(
                      Icons.double_arrow,
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
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
      onTap: (longitude, latitude, tilt) {
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
          widget: hotspotButton(
              hotSpot[id][index]['id'], hotSpot[id][index]['name']),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FloorPlanScreen()));
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
