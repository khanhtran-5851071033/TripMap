import 'dart:async';
import 'dart:ui';
import 'package:example/core/models/models.dart';
import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/view/screens/pano_screen.dart';
import 'package:example/view/shared/global.dart';
import 'package:example/view/widgets/appbar_widget.dart';
import 'package:example/view/widgets/positioned_widget.dart';
import 'package:example/view/widgets/raw_gesture_detector_widget.dart';
import 'package:example/view/widgets/reset_button_widget.dart';
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
  Timer _timer;
  @override
  void initState() {
    super.initState();

    // ignore: unused_local_variable
    _timer = new Timer.periodic(
        Duration(milliseconds: 100),
        (Timer timer) => setState(() {
              if (_opacity > 0.0) {
                if (_opacity < 0.04)
                  _opacity = 0.0;
                else
                  _opacity -= 0.04;
                size += 2;
              } else {
                size = 10;
                // Future.delayed(Duration(milliseconds: 100), () {
                _opacity = 0.7;
                // });
              }
            }));

    // _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
    //   setState(() {
    //     // _gyroscopeValues = <double>[event.x, event.y, event.z];
    //     // print(event.z);
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
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size scsize = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBarWidget(),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          height: scsize.height * 0.85,
          color: Colors.white,
          child: Center(
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
                            width: 410,
                            height: 380,
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
                              size: Size(410, 380),
                              painter: Painter(x: x, y: y),
                            ),
                          ),
                          // GridViewWidget(),
                          Container(
                              width: 410,
                              height: 380,
                              child: PositionedWidget()),
                          Container(
                            width: 410,
                            height: 380,
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
                          )
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
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
  double x, y;
  Painter({this.x, this.y});
  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.polygon;
    //330,370
    final points = [
      Offset(x, y),
      Offset(x, 100),
      Offset(100, 100),
      // Offset(130, 200),
      // Offset(270, 100),
    ];
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    // final paintPoint = Paint()
    //   ..color = Colors.blue
    //   ..strokeWidth = 10
    //   ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
    // canvas.drawPoints(
    //     pointMode,
    //     [
    //       Offset(x, y),
    //       Offset(x, y + 1),
    //     ],
    //     paintPoint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
