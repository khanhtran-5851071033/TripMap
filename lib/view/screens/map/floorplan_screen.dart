import 'dart:async';
import 'dart:ui';
import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/path_finder/dijsktra.dart';
import 'package:example/path_finder/repo_path.dart';
import 'package:example/view/screens/map/pano_screen.dart';
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

class _FloorPlanScreenState extends State<FloorPlanScreen>
    with SingleTickerProviderStateMixin {
  double x = 40, y = 200;
  double xdef = 40, ydef = 200;
  double step = 10, size = 20;

  String huong = '';
  int diemDau = 0, diemCuoi = 0;

  // List<double> _gyroscopeValues;
  // List<StreamSubscription<dynamic>> _streamSubscriptions =
  //     <StreamSubscription<dynamic>>[];
  AnimationController _controller;
  Animation _animation;
  Path _path;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
    _path = drawPath();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawPath() {
    Path path = Path();

    if (diemDau != 0 && diemCuoi != 0) {
      List<int> diem = Dijsktra.findPath(diemDau, diemCuoi);
      double prevX = 0;
      double prevY = 0;
      for (int i = 0; i < diem.length; i++) {
        for (int j = 0; j < listBuilding.length; j++) {
          if ((listBuilding[j].id) == diem[i]) {
            if (prevX == 0 && prevY == 0) {
              path.moveTo(
                  listBuilding[j].location.dx, listBuilding[j].location.dy);
              prevX = listBuilding[j].location.dx;
              prevY = listBuilding[j].location.dy;
            } else {
              path.quadraticBezierTo(prevX, prevY, listBuilding[j].location.dx,
                  listBuilding[j].location.dy);
              prevX = listBuilding[j].location.dx;
              prevY = listBuilding[j].location.dy;
            }
          }
        }
      }
    } else if (diemDau == 0 || diemCuoi == 0) {
      path.moveTo(0, 0);
    }
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
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
          clipBehavior: Clip.none,
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
                            'assets/1305.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      Stack(
                        children: [
                          Container(
                            //color: Colors.black.withOpacity(0.7),
                            child: CustomPaint(
                              size: Size(411.4, 411.4),
                              painter: Painter(path: _path),
                            ),
                          ),
                          Positioned(
                            top: (diemDau != 0 && diemCuoi != 0)
                                ? calculate(_animation.value).dy - 15
                                : 0,
                            left: (diemDau != 0 && diemCuoi != 0)
                                ? calculate(_animation.value).dx - 15
                                : 0,
                            child: Opacity(
                              opacity: (diemDau != 0 && diemCuoi != 0)
                                ? 1
                                : 0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.directions_walk_rounded),
                              ),
                            ),
                          ),
                        ],
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
                                  _path = drawPath();

                                  _controller.reset();
                                  _controller.repeat();
                                });
                              } else {
                                setState(() {
                                  diemDau = 0;
                                  diemCuoi = 0;
                                  _path = drawPath();

                                  _controller.repeat();
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
                              padding: EdgeInsets.fromLTRB(4, 5, 20, 5),
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
                                      Row(
                                        children: [
                                          Text(
                                            'Chỉ đường',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Icon(
                                            Icons.directions,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '360',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Icon(
                                            Icons.visibility_rounded,
                                            size: 18,
                                          )
                                        ],
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
  final Path path;

  Painter({this.path});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
