import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:example/core/models/models.dart';
import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/model/end_point.dart';
import 'package:example/path_finder/dijsktra.dart';
import 'package:example/path_finder/repo_path.dart';
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
  int diemDau = 0, diemCuoi = 0;

  // List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
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
                        width: 400,
                        height: 400,
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
                          size: Size(411.4, 411.4),
                          painter:
                              Painter(diemDau: diemDau, diemCuoi: diemCuoi),
                        ),
                      ),
                      // GridViewWidget(),
                      Container(
                          width: 411.4,
                          height: 411.4,
                          child: PositionedWidget(
                            findPath: (diem) {
                              if (diem.length == 2) {
                                setState(() {
                                  diemDau = diem[0];
                                  diemCuoi = diem[1];
                                });
                              } else {
                                setState(() {
                                  diemDau = 0;
                                  diemCuoi = 0;
                                });
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.white,
                height: scsize.height * 0.15,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(listBuilding.length, (index) {
                      return listBuilding[index].name == ''
                          ? Container()
                          : Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listBuilding[index].name,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        listBuilding[index].name,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        listBuilding[index].name,
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
  final int diemDau, diemCuoi;

  Painter({this.diemDau, this.diemCuoi});
  @override
  void paint(Canvas canvas, Size size) {
    if (diemDau != 0 && diemCuoi != 0) {
      final pointMode = PointMode.polygon;
      List<Offset> path = [];

      List<int> diem = Dijsktra.findPath(diemDau, diemCuoi);

      for (int i = 0; i < diem.length; i++) {
        for (int j = 0; j < listBuilding.length; j++) {
          if ((listBuilding[j].id) == diem[i]) {
            path.add(listBuilding[j].location);
          }
        }
      }
      if (path.isNotEmpty) {
        final paint = Paint()
          ..color = Colors.blue
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round;
        canvas.drawPoints(pointMode, path, paint);
      }
    } else if (diemDau == 0 || diemCuoi == 0) {
      final pointMode = PointMode.polygon;
      List<Offset> path = [Offset(0, 0), Offset(1, 1)];
      final paint = Paint()
        ..color = Colors.transparent
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;
      canvas.drawPoints(pointMode, path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
