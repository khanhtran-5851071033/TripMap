
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/end_point.dart';
import '../../path_finder/repo_path.dart';

class PositionedWidget extends StatefulWidget {
  final Function(List<int>) findPath;

  const PositionedWidget({Key key, this.findPath}) : super(key: key);
  @override
  _PositionedWidgetState createState() => _PositionedWidgetState();
}

class _PositionedWidgetState extends State<PositionedWidget> {
  final List<EndPoint> dayNha = listBuilding;

  List<int> diem = [];

  @override
  Widget build(BuildContext context) {
    // final List<Room> phongHoc =
    //     Global.phongHoc.map((item) => Room.fromMap(item)).toList();
    return Stack(
      children:
          // model.isScaled
          //     ? List.generate(phongHoc.length, (index) {
          //         return Positioned(
          //             left: phongHoc[index].position[0],
          //             top: phongHoc[index].position[1] - 20,
          //             child: Stack(
          //                 alignment: Alignment.centerLeft,
          //                 children: <Widget>[
          //                   Container(
          //                     width: 15,
          //                     child: CircleAvatar(
          //                       backgroundColor: Colors.red,
          //                       child: Icon(
          //                         Icons.room,
          //                         size: 10,
          //                       ),
          //                     ),
          //                   ),
          //                   Transform(
          //                     transform: Matrix4.identity()..translate(17.0),
          //                     child: Stack(
          //                       children: [
          //                         Text(
          //                           phongHoc[index].name,
          //                           style: TextStyle(
          //                             fontSize: 9,
          //                             foreground: Paint()
          //                               ..style = PaintingStyle.stroke
          //                               ..strokeWidth = 0.7
          //                               ..color = Colors.black,
          //                           ),
          //                         ),
          //                         Text(
          //                           phongHoc[index].name,
          //                           style: TextStyle(
          //                             fontSize: 9.0,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   )
          //                 ]));
          //       })
          // :
          List.generate(dayNha.length, (index) {
        return dayNha[index].name != ''
            ? Positioned(
                left: dayNha[index].location.dx - 45,
                top: dayNha[index].location.dy - 24,
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  splashColor: Colors.transparent,
                  onPressed: () {
                    print(diem.length.toString());
                    if (diem.length < 2) {
                      setState(() {
                        diem.add(dayNha[index].id);
                      });
                    } else {
                      setState(() {
                        diem.clear();
                        diem.add(dayNha[index].id);
                      });
                    }
                    widget.findPath(diem);
                  },
                  child:
                      Stack(alignment: Alignment.centerLeft, children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      // color: Colors.black54,
                      padding: EdgeInsets.all(15),
                      child: CircleAvatar(
                        backgroundColor: diem.contains(dayNha[index].id)
                            ? Colors.blue
                            : Colors.red,
                        child: Icon(
                          Icons.room,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.identity()..translate(39.0),
                      child: Stack(
                        children: [
                          Text(
                            dayNha[index].name,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            dayNha[index].name,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ]),
                ))
            : Container();
      }),
    );
  }
}
