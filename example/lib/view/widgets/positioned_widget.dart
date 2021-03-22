import 'package:example/core/models/models.dart';
import 'package:example/core/viewmodels/floorplan_model.dart';
import 'package:example/view/shared/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PositionedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);
    final List<Building> dayNha =
        Global.dayNha.map((item) => Building.fromMap(item)).toList();
    final List<Room> phongHoc =
        Global.phongHoc.map((item) => Room.fromMap(item)).toList();
    return Container(
      width: 410,
      height: 380,
      child: Stack(
        children: model.isScaled
            ? List.generate(phongHoc.length, (index) {
                return Positioned(
                    left: phongHoc[index].position[0],
                    top: phongHoc[index].position[1] - 20,
                    child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            width: 15,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.room,
                                size: 10,
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.identity()..translate(17.0),
                            child: Stack(
                              children: [
                                Text(
                                  phongHoc[index].name,
                                  style: TextStyle(
                                    fontSize: 9,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 0.7
                                      ..color = Colors.black,
                                  ),
                                ),
                                Text(
                                  phongHoc[index].name,
                                  style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]));
              })
            : List.generate(dayNha.length, (index) {
                return Positioned(
                    left: dayNha[index].position[0],
                    top: dayNha[index].position[1] - 20,
                    child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            width: 15,
                            child: CircleAvatar(
                              backgroundColor: dayNha[index].status
                                  ? Colors.black
                                  : Colors.red,
                              child: Icon(
                                dayNha[index].status ? Icons.room : Icons.close,
                                size: 10,
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.identity()..translate(17.0),
                            child: Stack(
                              children: [
                                Text(
                                  dayNha[index].name,
                                  style: TextStyle(
                                    fontSize: 9,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 0.7
                                      ..color = Colors.black,
                                  ),
                                ),
                                Text(
                                  dayNha[index].name,
                                  style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]));
              }),
      ),
    );
  }
}
