import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:example/core/models/models.dart';
import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/model/end_point.dart';
import 'package:example/view/screens/pano_screen.dart';
import 'package:example/view/shared/global.dart';
import 'package:example/view/shared/util.dart';
import 'package:example/view/widgets/appbar_widget.dart';
import 'package:example/view/widgets/positioned_widget.dart';
import 'package:example/view/widgets/raw_gesture_detector_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sensors/sensors.dart';

class FloorPlanScreen extends StatefulWidget {
  @override
  _FloorPlanScreenState createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {
  double x = 40, y = 200;
  double xdef = 40, ydef = 200;
  double step = 10, _opacity = 0.8, size = 20;
  int _direction = 0;
  String huong = '';

  // List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  final List<Building> dayNha =
      Global.dayNha.map((item) => Building.fromMap(item)).toList();
  @override
  void initState() {
    super.initState();

    // _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
    //   setState(() {
    //     // _gyroscopeValues = <double>[event.x, event.y, event.z];
    //     if (event.z > 2) {
    //       setState(() {
    //         _direction -= 1;
    //         huong = 'trai';
    //       });
    //     } else if (event.z < -2) {
    //       setState(() {
    //         _direction += 1;
    //         huong = 'phai';
    //       });
    //     } else {
    //       setState(() {
    //         huong = 'thang';
    //       });
    //     }
    //   });
    // }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size scsize = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);
    return Scaffold(
      backgroundColor: Util.myColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBarWidget(),
      ),
      body: Container(
        height: scsize.height * 0.85,
        color: Colors.white,
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 20,
              child: Container(
                color: Colors.red,
                child: RawGestureDetectorWidget(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: scsize.width,
                        height: scsize.width,
                        // color: Colors.grey,
                        child: Hero(
                          tag: 'mapUtc2',
                          child: Image.asset(
                            'assets/Utc2Map1.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),

                      Container(
                        // color: Colors.black.withOpacity(0.7),
                        child: CustomPaint(
                          size: Size(scsize.width, scsize.width),
                          painter: Painter(),
                        ),
                      ),
                      // GridViewWidget(),
                      Container(
                          width: scsize.width,
                          height: scsize.width,
                          child: PositionedWidget()),
                      Container(
                        width: scsize.width,
                        height: scsize.width,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              left: x - 30,
                              top: y - 30,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: _opacity,
                                    child: Container(
                                      // duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          shape: BoxShape.circle),
                                      height: size,
                                      width: size,
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 60,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                      // border: Border.all(
                                      //     width: 2, color: Colors.black)
                                    ),
                                    child: RotatedBox(
                                      quarterTurns: _direction,
                                      child: Icon(
                                        Icons.expand_less,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.transparent,
                height: scsize.height * 0.15,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(dayNha.length, (index) {
                      return Container(
                        // margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        padding: EdgeInsets.fromLTRB(4, 5, 10, 5),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/image.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dayNha[index].name,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  dayNha[index].name,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  dayNha[index].name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            // Positioned(
            //     bottom: 20,
            //     child: Container(
            //       decoration: BoxDecoration(
            //           // shape: BoxShape.circle,
            //           color: Colors.white.withOpacity(0.6),
            //           border: Border.all(width: 2, color: Colors.black38),
            //           borderRadius: BorderRadius.circular(10)),
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               ResetButtonWidget(),
            //               RaisedButton(
            //                   color: Colors.redAccent,
            //                   onPressed: () {
            //                     setState(() {
            //                       y = y - step;
            //                     });
            //                   },
            //                   child: Icon(Icons.arrow_upward)),
            //               RaisedButton(
            //                   color: Colors.blue,
            //                   onPressed: () {
            //                     setState(() {
            //                       x = xdef;
            //                       y = ydef;
            //                     });
            //                     // model.myScale(0, 0);
            //                   },
            //                   child: Icon(Icons.reset_tv))
            //             ],
            //           ),
            //           Row(
            //             children: [
            //               RaisedButton(
            //                   color: Colors.redAccent,
            //                   onPressed: () {
            //                     setState(() {
            //                       x = x - step;
            //                     });
            //                   },
            //                   child: Icon(Icons.arrow_back)),
            //               SizedBox(
            //                 width: 88,
            //               ),
            //               RaisedButton(
            //                   color: Colors.redAccent,
            //                   onPressed: () {
            //                     setState(() {
            //                       x = x + step;
            //                     });
            //                   },
            //                   child: Icon(Icons.arrow_forward))
            //             ],
            //           ),
            //           Row(
            //             children: [
            //               SizedBox(
            //                 width: 88,
            //               ),
            //               RaisedButton(
            //                   color: Colors.redAccent,
            //                   onPressed: () {
            //                     setState(() {
            //                       y = y + step;
            //                     });
            //                   },
            //                   child: Icon(Icons.arrow_downward)),
            //               SizedBox(
            //                 width: 88,
            //                 child: Text('$x $y'),
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.screen_rotation),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PanoScreen()));
        },
      ),
    );
  }
}

class Painter extends CustomPainter {
  // final List listBuilding;
  // Painter({this.listBuilding});
  var listBuilding = [
    EndPoint('C2', 'C2', Offset(170, 300), ['T1']),
    EndPoint('E7', 'E7', Offset(110, 110), ['T7']),
    EndPoint('T1', '', Offset(170, 288), ['C2', 'T2', 'T3']),
    EndPoint('T2', '', Offset(186, 288), ['T1', 'T6']),
    EndPoint('T3', '', Offset(124, 288), ['T1', 'T4']),
    EndPoint('T4', '', Offset(124, 236), ['T3']),
    EndPoint('T5', '', Offset(50, 236), ['T4']),
    EndPoint('T6', '', Offset(186, 236), ['T4']),
    EndPoint('T7', '', Offset(50, 110), ['T5', 'E7']),
  ];
  // var listTurn = [
  //   Offset(170, 288),
  //   // TurnPoint(Offset(170, 288),[])
  //   Offset(186, 288),
  //   Offset(124, 288),
  //   Offset(124, 236),
  //   Offset(50, 236),
  //   Offset(185, 236),
  //   Offset(50, 110)
  // ];
  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.polygon;

    var start = listBuilding[0];
    var end = listBuilding[1];
    var curNode = start;
    List<Offset> points = [];
    points.add(start.location);
    for (int i = 0; i < listBuilding.length; i++) {
      if (listBuilding[i].node.contains(curNode.id)) {
        points.add(listBuilding[i].location);
        curNode = listBuilding[i];
        i = 0;
      }
      // if(  sqrt(   pow(listBuilding[i].location.dx-curNode.dx,2)+ pow(listBuilding[i].location.dy-curNode.dy,2)    )  );
    }
    
    points.add(end.location);
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
